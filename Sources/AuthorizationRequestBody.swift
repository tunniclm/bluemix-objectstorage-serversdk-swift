/*
*     Copyright 2016 IBM Corp.
*     Licensed under the Apache License, Version 2.0 (the "License");
*     you may not use this file except in compliance with the License.
*     You may obtain a copy of the License at
*     http://www.apache.org/licenses/LICENSE-2.0
*     Unless required by applicable law or agreed to in writing, software
*     distributed under the License is distributed on an "AS IS" BASIS,
*     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*     See the License for the specific language governing permissions and
*     limitations under the License.
*/

import Foundation

internal class AuthorizationRequestBody {
	private var dict = [:];
	
	private let emptyObj = "{}"
	
	init(userId:String, password:String, projectId:String){
		dict =
			[
				"auth":[
					"identity":[
						"methods":["password"],
						"password":[
							"user": [
								"id":userId,
								"password":password
							]
						]
					],
					"scope":[
						"project":[
							"id":projectId
						]
					]
				]
			]
	}
	
	func data() -> NSData {
		do {
			#if swift(>=3)
				return try NSJSONSerialization.data(withJSONObject: dict, options: NSJSONWritingOptions.prettyPrinted)
			#else
				return try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
			#endif
			
		} catch {
			return NSData()
		}
	}
}