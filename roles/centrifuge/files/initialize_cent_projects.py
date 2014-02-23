import json

from cent.core import Client


def load_config():
    with open("config.json") as f:
        return json.loads(f.read())


def project_exists(admin_client):
    result, error = admin_client.send("project_list", {})
    if not result['error']:
        return 'wwc' in [project['name'] for project in result['body']]

    exit(1)  # connection error or otherwise


def get_project(name, admin_client):
    result, error = admin_client.send("project_list", {})
    if not result['error']:
        return [(project['_id'], project['secret_key'])
                for project in result['body']
                if project['name'] == 'wwc'][0]

    exit(1)  # connection error or otherwise


def create_project(name, admin_client):
    params = {"name": name, "display_name": name, }
    result, error = admin_client.send("project_create", params)
    if not result['error']:
        project_id = result['body']['_id']
        secret_key = result['body']['secret_key']
        return project_id, secret_key

    exit(1)  # connection error or otherwise


def create_namespace(name, project_id, secret_key):
    client = Client("http://localhost:8000/api", project_id, secret_key)
    result, error = client.send("namespace_create", {"name": name,
                                                     "publish": 1,
                                                     "presence": 1,
                                                     "history": 1,
                                                     "join_leave": 1, })


def main():
    config = load_config()
    admin_client = Client("http://localhost:8000/api",
                          "_",
                          config['api_secret'])
    if project_exists(admin_client):
        project_id, secret_key = get_project('wwc', admin_client)
    else:
        project_id, secret_key = create_project('wwc', admin_client)
        create_namespace('wwc', project_id, secret_key)

    print(project_id)  # for ansible's benefit
    print(secret_key)  # for ansible's benefit

if __name__ == "__main__":
    main()
