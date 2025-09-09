# Contributing to Canary Bit
The following is a set of guidelines to contribute to CanaryBit and its projects, which are hosted on the
[CanaryBit Organization](https://github.com/canarybit) on GitHub.
This project adheres to the [Contributor Covenant 2.1](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).
By participating, you are expected to uphold this code. Please report unacceptable behavior to [hi@canarybit.eu](mailto:hi@canarybit.eu).

### Reporting issues
Reporting issues is a great way to contribute to the project. 
We are grateful for a well-written, thorough bug report.
Before raising a new issue, check the issues page to determine if it already contains the problem that you are facing.
A good bug report should not leave others needing to chase you for more information. Please be as detailed as possible. The following questions might serve as a template for writing a detailed report:

- What were you trying to achieve?
- What are the expected results?
- What are the received results?
- What are the steps to reproduce the issue?
- In what environment did you encounter the issue?

### Pull requests
Good pull requests (e.g. patches, improvements, new features) are a fantastic help. 
They should remain focused on scope and avoid unrelated commits.
Please ask first before embarking on any significant pull request (e.g. implementing new features, refactoring code etc.), 
otherwise, you risk spending a lot of time working on something that the maintainers might not want to merge into the project.
Make sure to adhere to the coding conventions used throughout the project. 
For Rust-based repos, if in doubt, consult [The Rust Style](https://doc.rust-lang.org/nightly/style-guide/) guide
as well as the [Secure Rust Guidelines](https://anssi-fr.github.io/rust-guide/).

To contribute to the project, [fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) it, clone your fork repository, and configure the remotes:

> git clone https://github.com/<your-username>/<repo-name>.git  
> cd <repo-name>  
> git remote add upstream https://github.com/canarybit/<repo-name>.git

If your cloned repository is behind the upstream commits, then get the latest changes from upstream:
> git checkout main
> git pull --rebase upstream main

Create a new topic branch from main using the naming convention reponame-[issue-number] for your issues to help us keep 
track of your contribution scope:
> git checkout -b reponame-[issue-number]

Commit your changes in logical chunks. When you are ready to commit, make sure to write a commit message following the 
[Conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) style. 
Use interactive rebase to group your commits into logical units of work before making it public.
Note that every commit you make must be signed. By signing off your work, you indicate that you are accepting the 
[Developer Certificate of Origin](https://developercertificate.org/).
Use your real name (sorry, no pseudonyms or anonymous contributions). 
If you set your user.name and user.email git configs, you can sign your commit automatically with git commit -s.
Locally merge (or rebase) the upstream development branch into your topic branch:

> git pull --rebase upstream main

Push your topic branch up to your fork:
> git push origin reponame-[issue-number]

[Open a Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) with a clear title and detailed description.
