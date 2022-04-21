package todoapp

import (
	"dagger.io/dagger"
	"dagger.io/dagger/core"
)

dagger.#Plan & {
	client: {
		filesystem: {
			"./": {
				read: contents: dagger.#FS
				write: contents: actions.write.output
			}
		}
	}
	actions: {
		mkdir: core.#Mkdir & {
			input: client.filesystem."./".read.contents
			path: "bla"
		}
		write: core.#WriteFile & {
			input: mkdir.output
			path: "bla/hello.txt"
			contents: "hello, tom!"
		}
		// build: {
		// 	run: bash.#Run & {
		// 		// source: client.filesystem."./".read.contents
		// 		path: "bla"
		// 		workdir: "/src"
		// 		script: contents: #"""
		// 			dotnet test
		// 			"""#
		// 	}
		// }
	}
}