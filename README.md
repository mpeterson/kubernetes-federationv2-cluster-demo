# Kubernetes Federation v2 Demo

A demo based on the [Federation v2 examples](https://github.com/kubernetes-sigs/federation-v2/tree/master/example) as a starting point, and following [the Federation v2 user guide](https://github.com/kubernetes-sigs/federation-v2/blob/master/docs/userguide.md).

# Automated Preparation

Ansible logic for fully configuring the demo environment on RDO Cloud is
provided by the `deploy_fed.yml` playbook.

Follow [these
docs](https://docs.google.com/document/d/1ngJLTWKOCttSVbyv9MPPYL-mevxutYasgIoLTfy03hg)
to get an RDO Cloud account, do one-time account setup and launch an instance.

Make sure you have `ansible` and `ansible-playbook` installed on your local
machine.

Configure your Ansible hosts inventory with the IP of your instance on RDO
Cloud using the name fedv2demo.

Configure your RDO Cloud instance for the demo with `ansible-playbook
deploy_fed.yml`.

Once the Ansible playbook finishes, you should be ready to run `demo.sh`.

# Manual Preparation

Your local machine will have to be prepared to be able to use this demo in a successful manner.

First, install the following pre-requisites:

* [dep](https://github.com/golang/dep)
* [golang](https://golang.org/)
* [VirtualBox](https://www.virtualbox.org/)
* [minikube](https://github.com/kubernetes/minikube)

Second, use the following steps that might help you being able to compile federation-v2:

1. Set the GOPATH environment variable to something like `~/go`
2. `mkdir -p $GOPATH/src/github.com/kubernetes-sigs/`
3. `git clone https://github.com/kubernetes-sigs/federation-v2/ $GOPATH/src/github.com/kubernetes-sigs/federation-v2`
4. Set the PATH environment variable to include `$GOPATH/src/github.com/kubernetes-sigs/federation-v2/bin`
5. `cd $GOPATH/src/github.com/kubernetes-sigs/federation-v2`
6. `./scripts/download-binaries.sh`
7. As the time of writing the federation-v2 had a problem being compiled. This can be solved with:

```
cat >> Gopkg.toml << EOF
[[override]]
name = "github.com/Azure/go-autorest"
revision = "bca49d5b51a50dc5bb17bbf6204c711c6dbded06"
EOF
```

8. `dep ensure -v`
9. `go build -o bin/kubefed2 cmd/kubefed2/kubefed2.go`

If step 9 succeeded, then you should be able to use the demo.

# Usage

Run the demo including setting up the minikube VMs and the federation setup:

    ./demo.sh

Or to skip that part:

    ./demo.sh -s
