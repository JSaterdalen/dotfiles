#!/usr/bin/env node

// Raycast Script Command Template
//
// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/
//
// Duplicate this file and remove ".template" from the filename to get started.
// See full documentation here: https://github.com/raycast/script-commands
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title My First Script
// @raycast.mode fullOutput
// @raycast.packageName Raycast Scripts
//
// Optional parameters:
// @raycast.icon 🤖
// @raycast.argument1 { "type": "text", "placeholder": "query" }
//
// Documentation:
// @raycast.description Write a nice and descriptive summary about your script command here
// @raycast.author Your name
// @raycast.authorURL An URL for one of your social medias

/*

	ABOUT THIS TEMPLATE:
	
	This template is meant to be a quick starting point for creating a script command using Nodejs.
	
	This template demonstrates the following ideas:
	
	* Extracting passed arguments.
	* Using both required and optional arguments
	* URI Encoding
	* Outputting result to Raycast
	* Opening a url using exec and the unix open command
	* Use of destructuring
	* Use of template literals

*/

const { exec } = require('child_process');

// Use destructuring to grab arguments.
let query = process.argv[2];
console.log('query: ' + query);
// console.log() displays output in fullOutput mode.
// console.log(`The arguments are: \n   ${process.argv.join('\n   ')}\n`)
// console.log(`Your topic is "${topic}"`)
// console.log(`Your query is "${query}"`)
// console.log(`Your query uri encoded is "${encodeURIComponent(query)}"`)
// console.log(`The uri is "${uri}"`)

// Uncomment the exec line below to open this query in your web browser.
// Use double quotes around the uri to avoid processing issues.
//exec(`open "${uri}"`)

// async (clipboardContentString) => {
//         try {
//           const response = await fetch("https://api.openai.com/v1/completions", {
//             method: "POST",
//             headers: {
//               "Content-Type": "application/json",
//               "Authorization": "Bearer YOUR API KEY HERE"
//             },
//             body: JSON.stringify({
//               model: "text-davinci-003",
//               prompt: `${clipboardContentString}.`,
//               temperature: 0,
//               max_tokens: 256
//             })
//           });
//           const data = await response.json();
//           const text = data.choices[0].text;
//         return `${clipboardContentString} ${text}`;
//         } catch (error) {
//           return "Error"
//         }
//       }
