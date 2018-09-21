# Containaruba

This repo provides a docker image for testing CLI applications using [Aruba][1] which extends [Cucumber][2] to better handle CLI applications after checking all [Gherkin][3] conforms to a consistent style via [Cucumber Lint][4] all while wearing sunglass, even indoors!

# Usage

This container can be used to execute the feature files for any project that uses [Aruba][1].

## Setup

Primarily designed to get you running your tests as soon as possible. So the recommended usage is to volume mount your `features` directory into `/usr/src/app/features` and run Containaruba. You can see an example of this being done in [docker-compose.example.yml](./docker-compose.example.yml) as a reference.

Alternatively the image contains an [ONBUILD Directive][5] that will copy a `features` directory into the new image for you, ready to run. Simply use `nekroze/containaruba:latest` in your [FROM Directive][7].

## Execution

By default the image will execute all features in the `/usr/src/app/features` path however you can override the default [CMD][6] to specify a specific feature file.

## Features

For some basic examples and information on what this image can do, checkout its own [features](./features/smoke.feature)that get tested.
# Development

You can execute the tests to ensure no regressions in Containaruba by executing:

```bash
 $ ./test.sh
```

The main repository is also automatically tested by [Travis CI][8] using the exact same script.

[1]: https://app.cucumber.pro/projects/aruba
[2]: https://cucumber.io/
[3]: https://docs.cucumber.io/gherkin/
[4]: https://rubygems.org/gems/cucumber_lint
[5]: https://docs.docker.com/engine/reference/builder/#onbuild
[6]: https://docs.docker.com/engine/reference/builder/#cmd
[7]: https://docs.docker.com/engine/reference/builder/#from
[8]: https://travis-ci.org
