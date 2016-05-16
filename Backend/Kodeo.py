import urllib, json
from pprint import pprint
from datetime import datetime
import time
from flask import Flask,request,jsonify
import os

app = Flask(__name__)

@app.route('/')
def firstPage():
	return "Hello World"

@app.route('/getpointsForUser')
def api_hello():
	dic = {"totalPoints":0,"PushEvent":0,"PullRequestEvent":0,"IssueCommentEvent":0,"IssueEvent":0}
	points = 0
	client_id = "39c9aaea6e3c93cc9247"
	client_secret = "01203f23db09a26aa448511f9c0ddd68a2f7ad43"
	user = request.args['user']
	date2Str = datetime.fromtimestamp(time.time()).strftime('%Y-%m-%dT%H:%M:%SZ')
	currentDate = datetime.strptime(date2Str,'%Y-%m-%dT%H:%M:%SZ')

	for i in range(0,10):
		url = "https://api.github.com/users/" + user + "/events?page=" + str(i) + "&client_id=" + client_id + "&client_secret=" + client_secret
		print url
		response = urllib.urlopen(url)
		data = json.loads(response.read())
		print len(data)

		dateStr = data[0]["created_at"]
		commitDate = datetime.strptime(dateStr,'%Y-%m-%dT%H:%M:%SZ')
		if abs(currentDate - commitDate).days >= 10:
			break	
		
		for commit in data:
			payload = commit["payload"]
			commitType = commit["type"]
			print commitType
			if commitType == "PushEvent":
				points += 3
				dic["PushEvent"] += 1

			elif commitType == "PullRequestEvent":
				points += 4
				dic["PullRequestEvent"] += 1

			elif commitType == "IssueCommentEvent":
				points += 1
				dic["IssueCommentEvent"] += 1

			elif commitType == "IssueEvent":
				points += 2
				dic["IssueEvent"] += 1

	dic["totalPoints"] = points
	return str(json.dumps(dic))

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)