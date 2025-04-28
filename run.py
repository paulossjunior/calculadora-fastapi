import subprocess

def run_server():
    """
    Executa o servidor Uvicorn apontando para o aplicativo FastAPI.

    Este comando é equivalente a rodar manualmente no terminal:
    `uvicorn app.main:app --reload`

    - `app.main:app` refere-se ao arquivo `main.py` dentro da pasta `app`,
      e ao objeto `app` que é a instância FastAPI criada lá.
    - `--reload` ativa o recarregamento automático (útil para desenvolvimento),
      ou seja, toda vez que o código muda, o servidor reinicia automaticamente.

    Exceptions:
        subprocess.CalledProcessError: Se o comando falhar ao ser executado.
    """
    subprocess.run(["uvicorn", "app.main:app", "--reload"], check=True)

if __name__ == "__main__":
    """
    Ponto de entrada principal do script.

    Se o arquivo for executado diretamente (e não importado),
    a função `run_server` será chamada para iniciar o servidor.
    """
    run_server()
