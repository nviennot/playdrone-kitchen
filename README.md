Google Play Crawler Kitchen
===========================

---

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

2. Make sure you have the latest RVM:

        curl -L https://get.rvm.io | bash -s stable

3. Install Ruby:

        rvm install ruby-1.9.3-p392

4. Reload your shell (exit and come back).

5. Run the bootstrap script:

        ./bootstrap.sh

  This will download the ubuntu ISO, create the base VM image, and instantiate
  VMs matching the production environment.

  Note: Do not type anything in the VM window during the creation of the base VM
  image, it may break the installation procedure.

---

Google Play Crawler Kitchen is released under the MIT license.
