# Intoduction

This is example project, which shows how to 'dockerize' you Phoenix application.
All steps are wrapped into Makefile.

# Requirements
  * Docker (>=1.9.0)

# How it works?
First it creates "builder" image. It contains all dependencies that
are required to compile application, basicly just Erlang and Elixir.
Also this image has compile script (from `docker/compile.sh`).
This script creates [release](http://erlang.org/doc/design_principles/release_structure.html)
with our Phoenix app. As a result we get docker/web.tar.gz, which is
release with our application, ready to deploy.

The next step is creating image with our application. We have to provide
release, unpack it and prepare for starting. After that our
image is ready!
We can run it with:
`make docker_start`
or
`docker run -ti --rm --name web -p 80:80 web:latest `

Now you can visit [`localhost:80`](http://localhost:80) from your browser.

## Diagram:
![Diagram](https://www.websequencediagrams.com/cgi-bin/cdraw?lz=dGl0bGUgSW1hZ2UgcHJlcGFyYXRpb24KClVzZXItPitEb2NrZXIgc2VydmljZTogQ3JlYXRlIGJ1aWxkZXIgaW1hZ2UKABcOLT4tVXNlcjogb2sAHydjb250YWluZXIAOREqQgATEDogYwB-BXMAVSEAKBNQaG9lbml4IGFwcCBzb3VyY2UAgWAIAE8ZIHJlbGVhc2UKbm90ZSByaWdodCBvZiAAgQQUb21waWxpbmcgYW5kIGFzc2VtYmluZwoAgTIRAIIYCQBTCACBFxlkZXN0cm95CgABBwBkEgCDDxkAgTYHAIFpCEFQUACDFRcqAIIIDACDSgUAgj4k&s=modern-blue)

# TODO:
  * describe migration and prepare script for it
  * add some kind of `supervisord`
  * ?
