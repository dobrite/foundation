import json

from cent.core import Client


def load_config():
    with open("config.json") as f:
        return json.loads(f.read())


def create_project(name, config):
    client = Client("http://localhost:8000/api", "_", config['api_secret'])
    result, error = client.send("project_create", {"name": name,
                                                   "display_name": name, })
    if not result['error']:
        project_id = result['body']['_id']
        secret_key = result['body']['secret_key']
        return project_id, secret_key

    return None, None


def create_namespace(name, project_id, secret_key):
    client = Client("http://localhost:8000/api", project_id, secret_key)
    result, error = client.send("namespace_create", {"name": name,
                                                     "publish": 1,
                                                     "presence": 1,
                                                     "history": 1,
                                                     "join_leave": 1, })


def main():
    config = load_config()
    project_id, secret_key = create_project('wwc', config)
    if project_id and secret_key:
        print(project_id)
        print(secret_key)
        create_namespace('wwc', project_id, secret_key)
        exit(0)
    exit(1) # signal to ansible

if __name__ == "__main__":
    main()
