# docker-image-postfix

A docker image for the postfix mail server application.

## Getting started

This Docker image contains a simple bash script that extracts the environment variables starting with `POSTFIX_` and applies them with the `postconf -e` command. This command allows us to configure Postfix from the environment without modifying any configuration file. By default, this script drops the `POSTFIX_` prefix and lowercases the keys. For a list of available arguments, see the official [documentation](http://www.postfix.org/postconf.5.html) page.

Example:

```bash
POSTFIX_MAILLOG_FILE   --> maillog_file
```

```bash
POSTFIX_maillog_file   --> maillog_file
```

## Releasing a new image version

Since this repository provides an automation to build and release new images, we recommend to use the following workflow:

```bash
git tag vX.X.X
git push origin vX.X.X
```
