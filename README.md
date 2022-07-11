# Ohala Jhipster Example POC Project
Presented for your consideration is my take on the **Ohalo Devops Technical Task**. My read on the Context and Parameters is that this could (or might) run off someone's workstation/laptop as a form of presentation. Keeping with the theme of "The deployment does not need to be production ready" the deployment itself is slim but could be made larger to suit an *actual* demo appropriately and easily.

## Summary
One may well ask, what is it? I've chosen to implement this POC with Vagrant. Hopefully you're familiar with this tool, if not then you're probably familiar with something else from the same company. Hashicorp makes some of the best power tools available and in my opinion few of those are better than Vagrant. Vagrant provides me with a couple of things: flexibility on the virtual back end, and fast prototyping in a provisioning language de jour. In this project I've chosen Chef to do most of my heavy lifting because it is the tool I work with on a near daily basis.

## Use
This specific example requires the following tooling:
 * Vagrant
 * Virtual Box

Assuming you already have both items, from the root of **this** project, execute `vagrant up` - after a fairly long build process, you'll be left with a Virtual Box VM that has the deployed results running and ready for use per the example from the Ohalo Github project. The VM, once provisioned can be stopped and started like any VM and will be ready for use in its completed form.

Once the VM is running and fully provisioned you can connect to it either via the example service ports or for more direct control via the shell, `vagrant ssh` to connect locally.

## Why?
I use Vagrant a lot for proof of concept work. Down the line the *provisioning language* I've chosen often gets reused, extended, turned into CI it's hard to know (especially if I'm not the developer, just the idea deployer) in the Early Days. Digital speculation is cheap and mostly painless but in the end I need debugability, reuse is a bonus that I not exactly banking on in a POC but it's expected.

Vagrant can also be extended to other virtualization platforms so what works on Virtual Box can be easily adjusted to work on any of the heavy hitters. More so though, just thumbnail sketching a service into the provisioned, component parts in a repeatable way makes it easy to pass that same work on to a Packer or Terraform for the next step.