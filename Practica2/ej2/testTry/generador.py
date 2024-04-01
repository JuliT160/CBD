from random import randrange
import requests
import json

generos = ['Rock', 'Pop', 'Jazz', 'Clasica', 'Electronica']

def obtener_nombre_autor_aleatorio():
    response = requests.get('https://randomuser.me/api/')
    data = response.json()
    return data['results'][0]['name']['first']

def generar_discos():
    discos = []
    for i in range(1, 101):
        disco = {
            "codAutor": i,
            "nombreAutor": obtener_nombre_autor_aleatorio(),
            "nombreDisco": f"Disco{i}",
            "genero": generos[i % len(generos)],  # Generar género ficticio
            "cantidadVendida": randrange(20, 5000, 1)  # Cantidad vendida ficticia
        }
        discos.append(disco)
    # Ordenar la lista de discos por código de autor, género y nombre de disco
    discos.sort(key=lambda x: (x['codAutor'], x['genero'], x['nombreDisco']))
    return discos

if __name__ == '__main__':
    discos = generar_discos()
    with open('discos.txt', 'w', encoding='utf-8') as f:
        for disco in discos:
            f.write(f"{disco['codAutor']};{disco['nombreAutor']};{disco['nombreDisco']};{disco['genero']};{disco['cantidadVendida']}\n")
            
