import json

class Rotations(object):
    @staticmethod
    def _rotate_node_x_90(node):
        outputs = {
            1:3,
            2:1,
            3:4,
            4:2,
            5:7,
            6:5,
            7:8,
            8:6
        }
        return outputs[node]
    @staticmethod
    def _rotate_node_x_180(node):
        return Rotations._rotate_node_x_90(Rotations._rotate_node_x_90(node))
    @staticmethod
    def _rotate_node_x_270(node):
        return Rotations._rotate_node_x_90(Rotations._rotate_node_x_180(node))
    @staticmethod
    def _rotate_node_y_90(node):
        outputs = {
            1:2,
            2:6,
            3:4,
            4:8,
            5:1,
            6:5,
            7:3,
            8:7
        }
        return outputs[node]
    @staticmethod
    def _rotate_node_y_180(node):
        return Rotations._rotate_node_y_90(Rotations._rotate_node_y_90(node))
    @staticmethod
    def _rotate_node_y_270(node):
        return Rotations._rotate_node_y_90(Rotations._rotate_node_y_180(node))
    @staticmethod
    def _rotate_node_z_90(node):
        outputs = {
            1:5,
            2:6,
            3:1,
            4:2,
            5:7,
            6:8,
            7:3,
            8:4
        }
        return outputs[node]
    @staticmethod
    def _rotate_node_z_180(node):
        return Rotations._rotate_node_z_90(Rotations._rotate_node_z_90(node))
    @staticmethod
    def _rotate_node_z_270(node):
        return Rotations._rotate_node_z_90(Rotations._rotate_node_z_180(node))
    @staticmethod
    def _rotate_node(node, x, y, z):
        new_node = node
        match y:
            case 90:
                new_node = Rotations._rotate_node_y_90(new_node)
            case 180:
                new_node = Rotations._rotate_node_y_180(new_node)
            case 270:
                new_node = Rotations._rotate_node_y_270(new_node)
        match x:
            case 90:
                new_node = Rotations._rotate_node_x_90(new_node)
            case 180:
                new_node = Rotations._rotate_node_x_180(new_node)
            case 270:
                new_node = Rotations._rotate_node_x_270(new_node)
        match z:
            case 90:
                new_node = Rotations._rotate_node_z_90(new_node)
            case 180:
                new_node = Rotations._rotate_node_z_180(new_node)
            case 270:
                new_node = Rotations._rotate_node_z_270(new_node)
        return new_node
    @staticmethod
    def rotate_nodes(nodes, x, y, z):
        new_nodes = []
        for node in nodes:
            new_nodes.append(Rotations._rotate_node(node, x, y, z))
        new_nodes.sort()
        return new_nodes

def get_variant_data(variant_nodes):
    data = {}
    for z in range(0, 360, 90):
        for x in range(0, 360, 90):
            for y in range(0, 360, 90):
                rotated_nodes = Rotations.rotate_nodes(variant_nodes, x, y, z)
                key = 0
                for b in rotated_nodes:
                    key += 1 << (b - 1)
                if not key in data:
                    data[key] = {
                        #"nodes": rotated_nodes,
                        "rotation": (x, y, z)
                    }
    return data

# Nodes
#   3 _______________7
#    /:             /|
#  4/_;____________/ |
#   | :           8| |
#   | :            | |
#   | :            | |
#   |1:............|.|5
#  2|/_____________|/6

variants = [
    [],
    [2],
    [2, 6],
    [2, 8],
    [1, 5, 6],
    [1, 2, 5, 6],
    [1, 4, 5, 6],
    [2, 3, 5, 8],
    [1, 2, 3, 5],
    [1, 3, 5, 6],
    [2, 7],
    [2, 6, 7],
    [4, 6, 7],
    [2, 4, 5, 7],
    [1, 2, 5, 7]
]

full_data = {}
for i, variant_nodes in enumerate(variants):
    variant_data = get_variant_data(variant_nodes)
    for permutation in variant_data:
        variant_data[permutation]["variant"] = i
    full_data |= variant_data
full_data = dict(sorted(full_data.items()))

with open('data.json', 'w') as f:
    json.dump(full_data, f)