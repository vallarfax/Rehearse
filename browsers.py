"""
A Python script to make starting and stopping browser containers a bit easier
"""

from subprocess import call
import argparse


def start(args):
	for browser in args.browser:
		call('sudo docker run -d -e HUB_ADDRESS={} vallarfax/selenium-{}'.format(args.hub, browser), shell=True)


def stop(args):
	for browser in args.browser:
		call("sudo docker ps --no-trunc | grep '{0}' | awk '{{print $1}}' | sudo xargs --no-run-if-empty docker stop".format(browser), shell=True)
	call("sudo docker ps -a -q --no-trunc | grep '{0}' | awk '{{print $1}}' | sudo xargs --no-run-if-empty docker rm".format(browser), shell=True)


def main():
	parser = argparse.ArgumentParser(description='Manage docker container browsers.')
	subparsers = parser.add_subparsers(help='commands')

	start_parser = subparsers.add_parser('start', help='Start browser containers')
	start_parser.add_argument('browser', action='store', nargs='*', default=['firefox', 'chrome'], help='Browsers to start')
	start_parser.add_argument('--hub', action='store', default='172.16.65.199', help='Address of the selenium hub')
	start_parser.set_defaults(func=start)

	stop_parser = subparsers.add_parser('stop', help='Stops browser containers')
	stop_parser.add_argument('browser', action='store', nargs='*', default=['firefox', 'chrome'], help='Browsers to stop')
	stop_parser.set_defaults(func=stop)

	args = parser.parse_args()
	args.func(args)


if __name__ == '__main__':
	main()
