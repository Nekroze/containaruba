Feature: Smoke test
	Ensure that we can run some Aruba specific gherkin.

	Scenario: Can execute command
		Given the directory "/bin" should exist

		When I run `ls /`

		Then it should pass with "bin"

	Scenario: Readme exists in the container
		Then a file named "/README.md" should exist

	Scenario: Is not running as root
		When I successfully run `id -u`

		Then the output should not contain exactly "0"

	Scenario Outline: Various commands are available:
		When I run `which <COMMAND>`

		Then it should pass with "<COMMAND>"

		Examples:
			| COMMAND        |
			| docker         |
			| docker-compose |
			| sh             |
			| bash           |
