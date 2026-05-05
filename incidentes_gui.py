import os
import tkinter as tk
from tkinter import ttk, messagebox
from typing import Any



def load_env(path: str = ".env") -> None:
    if not os.path.exists(path):
        return
    with open(path, "r", encoding="utf-8") as env_file:
        for raw_line in env_file:
            line = raw_line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            key = key.strip()
            value = value.strip().strip('"').strip("'")
            if key and key not in os.environ:
                os.environ[key] = value


class Database:
    def __init__(self) -> None:
        self.conn = None

    def _ensure_connection(self) -> None:
        if self.conn is not None and not self.conn.closed:
            return

        import psycopg2
        import psycopg2.extras

        load_env()
        self.conn = psycopg2.connect(
            host=os.getenv("DB_HOST", "localhost"),
            port=os.getenv("DB_PORT", "5432"),
            dbname=os.getenv("DB_NAME", "postgres"),
            user=os.getenv("DB_USER", "postgres"),
            password=os.getenv("DB_PASSWORD", ""),
        )

    def fetch_all_dict(self, sql: str, params: tuple[Any, ...] = ()) -> list[dict[str, Any]]:
        self._ensure_connection()
        import psycopg2.extras
        with self.conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
            cur.execute(sql, params)
            return [dict(row) for row in cur.fetchall()]


class IncidentesApp(tk.Tk):
    def __init__(self) -> None:
        super().__init__()
        self.title("SISI Tools - Main")
        self.geometry("1200x760")

        self.db = Database()

        self.main_frame = ttk.Frame(self, padding=16)
        self.main_frame.pack(fill="both", expand=True)

        ttk.Label(self.main_frame, text="Pantalla principal", font=("Arial", 18, "bold")).pack(anchor="w")
        ttk.Label(self.main_frame, text="Opciones:", font=("Arial", 12)).pack(anchor="w", pady=(12, 4))

        ttk.Button(
            self.main_frame,
            text="1) Consulta incidente",
            command=self.open_consulta_incidente,
            width=30,
        ).pack(anchor="w", pady=6)

    def open_consulta_incidente(self) -> None:
        ConsultaIncidenteWindow(self, self.db)


class ConsultaIncidenteWindow(tk.Toplevel):
    RELATED_TABLES = [
        "incaccion",
        "presupuesto",
        "serviciosext",
        "movimientoequipo",
    ]

    def __init__(self, master: tk.Tk, db: Database) -> None:
        super().__init__(master)
        self.db = db
        self.title("Consulta incidente")
        self.geometry("1400x860")

        self.search_frame = ttk.LabelFrame(self, text="Filtros de búsqueda", padding=12)
        self.search_frame.pack(fill="x", padx=12, pady=12)

        self.inccabeceraid_var = tk.StringVar()
        self.legnro_var = tk.StringVar()
        self.detalle_var = tk.StringVar()
        self.organismo_var = tk.StringVar()

        self._build_filters()

        self.result_frame = ttk.LabelFrame(self, text="Resultados", padding=10)
        self.result_frame.pack(fill="both", expand=True, padx=12, pady=(0, 12))

        result_container, self.result_tree = self._create_tree(self.result_frame)
        result_container.pack(fill="x", expand=False)
        self.result_tree.bind("<<TreeviewSelect>>", self.on_select_incidente)

        self.tabs = ttk.Notebook(self.result_frame)
        self.tabs.pack(fill="both", expand=True, pady=(10, 0))

        self.tab_trees: dict[str, ttk.Treeview] = {}
        for table_name in ["inccabecera", *self.RELATED_TABLES]:
            tab = ttk.Frame(self.tabs)
            self.tabs.add(tab, text=table_name)
            tab_container, tree = self._create_tree(tab)
            tab_container.pack(fill="both", expand=True)
            self.tab_trees[table_name] = tree

        self.incidentes_cache: list[dict[str, Any]] = []

    def _build_filters(self) -> None:
        ttk.Label(self.search_frame, text="inccabeceraid:").grid(row=0, column=0, sticky="w", padx=6, pady=4)
        ttk.Entry(self.search_frame, textvariable=self.inccabeceraid_var, width=20).grid(row=0, column=1, sticky="w", padx=6, pady=4)

        ttk.Label(self.search_frame, text="legnro (silegnro):").grid(row=0, column=2, sticky="w", padx=6, pady=4)
        ttk.Entry(self.search_frame, textvariable=self.legnro_var, width=20).grid(row=0, column=3, sticky="w", padx=6, pady=4)

        ttk.Label(self.search_frame, text="Texto en inccabeceradetalle:").grid(row=1, column=0, sticky="w", padx=6, pady=4)
        ttk.Entry(self.search_frame, textvariable=self.detalle_var, width=35).grid(row=1, column=1, sticky="w", padx=6, pady=4)

        ttk.Label(self.search_frame, text="Organismo (código o nombre):").grid(row=1, column=2, sticky="w", padx=6, pady=4)
        ttk.Entry(self.search_frame, textvariable=self.organismo_var, width=35).grid(row=1, column=3, sticky="w", padx=6, pady=4)

        ttk.Button(self.search_frame, text="Buscar", command=self.buscar).grid(row=2, column=3, sticky="e", padx=6, pady=(10, 2))

    def _create_tree(self, parent: tk.Widget) -> tuple[ttk.Frame, ttk.Treeview]:
        container = ttk.Frame(parent)

        tree = ttk.Treeview(container, show="headings")
        tree.grid(row=0, column=0, sticky="nsew")

        vsb = ttk.Scrollbar(container, orient="vertical", command=tree.yview)
        hsb = ttk.Scrollbar(container, orient="horizontal", command=tree.xview)
        tree.configure(yscrollcommand=vsb.set, xscrollcommand=hsb.set)

        vsb.grid(row=0, column=1, sticky="ns")
        hsb.grid(row=1, column=0, sticky="ew")

        container.rowconfigure(0, weight=1)
        container.columnconfigure(0, weight=1)
        return container, tree

    def buscar(self) -> None:
        filters = []
        params: list[Any] = []

        if self.inccabeceraid_var.get().strip():
            filters.append("ic.inccabeceraid = %s")
            params.append(int(self.inccabeceraid_var.get().strip()))

        if self.legnro_var.get().strip():
            filters.append("ic.silegnro = %s")
            params.append(int(self.legnro_var.get().strip()))

        if self.detalle_var.get().strip():
            filters.append("ic.inccabeceradetalle ILIKE %s")
            params.append(f"%{self.detalle_var.get().strip()}%")

        if self.organismo_var.get().strip():
            filters.append("(TRIM(ic.siorgcodigo) ILIKE %s OR o.organismonombre ILIKE %s)")
            org = f"%{self.organismo_var.get().strip()}%"
            params.extend([org, org])

        where_sql = " AND ".join(filters) if filters else "TRUE"
        sql = f"""
            SELECT
                ic.inccabeceraid,
                ic.inccabecerafechaini,
                ic.inccabecerafechafin,
                ic.silegnro,
                ic.siorgcodigo,
                ic.inccabeceraestado,
                ic.inccabeceraprioridad,
                ic.problemaid,
                ic.tipoproblemaid,
                LEFT(ic.inccabeceradetalle, 240) AS inccabeceradetalle
            FROM public.inccabecera ic
            LEFT JOIN public.organismo o
              ON TRIM(ic.siorgcodigo) = TRIM(o.organismocodigo)
            WHERE {where_sql}
            ORDER BY ic.inccabeceraid DESC
            LIMIT 200
        """

        try:
            self.incidentes_cache = self.db.fetch_all_dict(sql, tuple(params))
            self.populate_tree(self.result_tree, self.incidentes_cache)
            self.clear_detail_tabs()
        except ValueError:
            messagebox.showerror("Error", "inccabeceraid y legnro deben ser numéricos")
        except Exception as exc:
            messagebox.showerror("Error", f"No se pudo ejecutar la búsqueda:\n{exc}")

    def clear_detail_tabs(self) -> None:
        for tree in self.tab_trees.values():
            tree.delete(*tree.get_children())
            tree["columns"] = []

    def on_select_incidente(self, _event: tk.Event) -> None:
        selected = self.result_tree.selection()
        if not selected:
            return
        row_index = int(selected[0])
        if row_index >= len(self.incidentes_cache):
            return
        incidente = self.incidentes_cache[row_index]
        inccabeceraid = incidente["inccabeceraid"]
        self.load_detail_tabs(inccabeceraid)

    def load_detail_tabs(self, inccabeceraid: int) -> None:
        main_rows = self.db.fetch_all_dict(
            "SELECT * FROM public.inccabecera WHERE inccabeceraid = %s",
            (inccabeceraid,),
        )
        self.populate_tree(self.tab_trees["inccabecera"], main_rows)

        for table in self.RELATED_TABLES:
            rows = self.db.fetch_all_dict(
                f"SELECT * FROM public.{table} WHERE inccabeceraid = %s ORDER BY 1",
                (inccabeceraid,),
            )
            self.populate_tree(self.tab_trees[table], rows)

    def populate_tree(self, tree: ttk.Treeview, rows: list[dict[str, Any]]) -> None:
        tree.delete(*tree.get_children())
        if not rows:
            tree["columns"] = ["sin_datos"]
            tree.heading("sin_datos", text="Sin datos")
            tree.column("sin_datos", width=180, stretch=False)
            return

        columns = list(rows[0].keys())
        tree["columns"] = columns

        for col in columns:
            tree.heading(col, text=col)
            tree.column(col, width=180, stretch=True)

        for idx, row in enumerate(rows):
            values = [row.get(col, "") for col in columns]
            tree.insert("", "end", iid=str(idx), values=values)


if __name__ == "__main__":
    app = IncidentesApp()
    app.mainloop()
