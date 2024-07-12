# Dockerfile for Runner

[base](https://medium.com/dazn-tech/github-self-hosted-runners-on-ecs-f0f7182a3297)

## How it works

The files in this folder are to build the docker images for both the orchestrator and the ephemeral runner. They use the same dockerfile and only trade out what scripts are run as the entrypoint. They use the same Dockerfile by use of the `docker buildx bake` command. 

To build both the docker images, run `docker buildx bake all` to build both images simultaneously. The `docker-bake.hcl` file contains all the information for building both files. The `start.sh` scripts are in the orchestrator and ephemeral folders.

There is a third folder named testing that will echo Hello World and then sleep. This is used for debugging the docker images/docker build process


## Required shell Envirionment Variables
- `DEBUG` - optional
- `GITHUB_PERSONAL_TOKEN`
- `GITHUB_REPOSITORY`
- `GITHUB_ORG`
- `DESTINATION`
- `RUNNER_GROUP`
- `RUNNER_LABELS`