import matplotlib.pyplot as plt
import networkx as nx

G = nx.DiGraph()

# Nodes for states
G.add_node("Reserve (E)")
G.add_node("Structure (V/W)")
G.add_node("Maturity (E_H)")
G.add_node("Repro Buffer (E_R)")
G.add_node("Food")
G.add_node("Cocoon")
G.add_node("Juvenile")
G.add_node("Adult")

# Fluxes
G.add_edge("Food", "Reserve (E)", label="Assimilation (p_Am)")
G.add_edge("Reserve (E)", "Structure (V/W)", label="Growth (p_G)")
G.add_edge("Reserve (E)", "Maturity (E_H)", label="Maturation")
G.add_edge("Reserve (E)", "Repro Buffer (E_R)", label="Reproduction")
G.add_edge("Repro Buffer (E_R)", "Cocoon", label="Cocoon production")
G.add_edge("Cocoon", "Juvenile", label="Hatch")
G.add_edge("Juvenile", "Adult", label="Puberty")

pos = {
    "Food": (0, 2),
    "Reserve (E)": (1, 2),
    "Structure (V/W)": (2, 3),
    "Maturity (E_H)": (2, 1),
    "Repro Buffer (E_R)": (3, 2),
    "Cocoon": (4, 2),
    "Juvenile": (5, 2),
    "Adult": (6, 2)
}

plt.figure(figsize=(10,4))
nx.draw(G, pos, with_labels=True, node_color='lightblue', node_size=2000, font_size=10, arrowsize=20)
edge_labels = nx.get_edge_attributes(G, 'label')
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels, font_color='red')
plt.title("DEB Model: States and Fluxes with Life Stages")
plt.axis('off')
plt.show()