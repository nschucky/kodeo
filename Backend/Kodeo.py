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
	dic = {"username": "", "userPic": "", "totalPoints":0,"dailyPoints":[],"PushEvent":0,"PullRequestEvent":0,"IssueCommentEvent":0,"IssueEvent":0}
	points = 0
	dailyPoints = {}
	client_id = "39c9aaea6e3c93cc9247"
	client_secret = "01203f23db09a26aa448511f9c0ddd68a2f7ad43"
	user = request.args['user']
	date2Str = datetime.fromtimestamp(time.time()).strftime('%Y-%m-%dT%H:%M:%SZ')
	currentDate = datetime.strptime(date2Str,'%Y-%m-%dT%H:%M:%SZ')


	for i in range(0,10):

		dayPoints = 0
		url = "https://api.github.com/users/" + user + "/events?page=" + str(i) + "&client_id=" + client_id + "&client_secret=" + client_secret
		print url
		response = urllib.urlopen(url)
		data = json.loads(response.read())
		print len(data)

		#Username & pic
		if dic["userPic"] == "":
			dic["userPic"] = data[0]["actor"]["avatar_url"]
			dic["username"] = data[0]["actor"]["login"]

 		dateStr = data[0]["created_at"]
 		print(dateStr)
		commitDate = datetime.strptime(dateStr,'%Y-%m-%dT%H:%M:%SZ')
		if abs(currentDate - commitDate).days >= 10:
			break	

		dateStr = dateStr[5:10]	
		for commit in data:
			payload = commit["payload"]
			commitType = commit["type"]
			print commitType
			if commitType == "PushEvent":
				points += 3
				dayPoints += 3
				dic["PushEvent"] += 1

			elif commitType == "PullRequestEvent":
				points += 4
				dayPoints += 4
				dic["PullRequestEvent"] += 1

			elif commitType == "IssueCommentEvent":
				points += 1
				dayPoints += 1
				dic["IssueCommentEvent"] += 1

			elif commitType == "IssueEvent":
				points += 2
				dayPoints += 2
				dic["IssueEvent"] += 1
		print(points)	
		
		if dateStr in dailyPoints.keys():
			dailyPoints[dateStr] += dayPoints
		else: 
			dailyPoints[dateStr] = dayPoints 

	dic["totalPoints"] = points
	dic["dailyPoints"] = dailyPoints
	print dailyPoints
	print points
	return str(json.dumps(dic))

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)