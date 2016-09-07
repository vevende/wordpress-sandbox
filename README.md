# wordpress-sandbox

A wordpress sandbox ready to develop with docker containers.

**WARNING: This is not intended for production use**  

## Usage

Install docker compose -> https://docs.docker.com/compose/install/

Build the environment:

    docker-compose up

Then open http://localhost:8080/ and have fun!


## Development tools

A firt boot for developers could look like this:

    wp package install danielbachhuber/dictator
    wp plugin install woocommerce
    wp plugin install debug-bar
    wp plugin install debug-bar-extender
    wp plugin install custom-post-type-ui
    wp plugin install show-current-template
    wp plugin install smart-custom-fields 
    wp dictator impose site-state.yml
