# Utilitzem la imatge oficial de Python
FROM python:3.10-slim

# Definim el directori de treball dins del contenidor
WORKDIR /app

# Copiem el fitxer de requeriments i instal·lem les dependències
# Incloem pylint i pytest per a l'anàlisi i els tests
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install pylint pytest pytest-cov

# Copiem tot el codi del projecte (main.py, transform.py, test.py)
COPY . .

# Executem l'analitzador de codi estàtic (pylint)
# Posem --exit-zero perquè el build no falli si hi ha avisos de format
RUN pylint main.py transform.py --exit-zero

# Comanda per defecte: executa els tests i mostra el coverage per pantalla
CMD ["pytest", "--cov=transform", "test.py"]
