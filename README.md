# LP - DevOps - 2020 - ansible - Grp2 - Python - 1

### Liste des étudiants.

DI FLORIO Madhava - p1925518

### Les clés ssh de connexion:

The ssh key is located within the project directory. p1925518-key.pem

### Les technologies utilisées:

-   PostgreSQL
-   Flask for the web app.
-   Gunicorn to run flask.
-   Nginx for the web sever/reverse proxy.
-   Git to get the project files for the Flask application.

### La liste des roles (si utilisés)

All the roles were created by me, I didn't use any roles from Ansible-Galaxy.

### La liste des commandes à utiliser.

The Makefile contains the following commands.

```
deploy-test-prod
deploy-test-preprod
deploy-test-all

deploy-prod
deploy-preprod
deploy-all

test-prod
test-preprod

test-prod-db
test-preprod-db

show-tags
```

If you want to change the IP addresses of the hosts. You need to modify the Makefile and the hosts.yaml file.

To run the project you can select `deploy-test-prod` or `deploy-test-preprod` or `deploy-test-all`. These commands will run the deployment and then run a little test.

Alternatively, each of the roles has tags associated so that you can run each role or task seperately. The task prerequisites needs to be run before the roles.

If you want to see all the possible tags, run the command `show-tags`.

Keep in mind, I used variables to target specific machines. So if you want to run individual tasks using the tags you need to add `--extra-vars "target=all"` to your ansible command. The target can be `all`, `prod` or `preprod`. If this isn't clear, you can see examples of this inside the Makefile.

### Une présentation de l'architecture mise en place

The project has been set up so that it does 4 things.

1. Install all prerequisites such as Python, Pip and VirtualEnv. VirtualEnv is used to create a virtual environment that allows us to install Python packages that are required to run the Flask application. The application can be found [here](https://github.com/mierz00/flask-hello-world) which is just a fork of a hello world flask application. I have created two branches a preprod and a prod branch, there is also a list of releases.

2) Installation and configuration of PostGreSQL. This installation is quite standard and simply creates a new user and database.

3) Cloning or pulling the Flask application onto the server. This is done in two different ways depending on which server we're on.

    - Production server
        - Get the latest release number.
        - Git clone the latest release of the application into `/var/www/{{ app_name }}/releases/{{ latest_tag }}` This way, we have atomic deployments with a coherent naming convention for each folder.
        - Copy the message template into message.py
        - Install all the required packages inside the virtual environment.
        - Change the symbolic link so that Nginx can know which application to serve.
    - Preproduction server

        - Clone or update the latest release from the branch pre-prod in the repo.
        - Copy the message template into message.py
        - Install the packages.
        - Update the symbolic link.

    - The reason why I did things this way is so that the production server always uses the [latest release](https://github.com/mierz00/flask-hello-world/releases) and that the preproduction takes the latest update from the preprod branch. This way we can make quick modifications to the preproduction if required and we can be sure that the production server never adds anything but the latest release. In the case of a mistake, we can always change the symbolic link on the production server and downgrade to an earlier version of the application.

4. Installation and configuration of Nginx and Gunicorn.

    - Nginx is installed and the configured using templates. These templates contain the app_name. We then run the Gunicorn server to launch the Flask application. This server creates a .sock file which is used by Nginx to expose the server to the outside world on the port 80. That way, we can access the application from the outside.
