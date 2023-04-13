I created CI/CD pipeline using github actions.
To do that I created a service account for my terraform, I added JSON file with my key to my service account and stored in github actions
I prepared yaml file with definition of my pipeline. I push this file to my repo and initialized github actions sections which allows me to automate terraform init, plan, apply.
It gave me a posiibility to built automatic CI/CD pipeline and push code to my repo to trigerred all process which end of deploy my infrastructure