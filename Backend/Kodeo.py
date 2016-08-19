import urllib, json
from pprint import pprint
from datetime import datetime
import time
from flask import Flask,request,jsonify
import os
import ghstreak
import requests

app = Flask(__name__)

@app.route('/')
def firstPage():
	return "Hello World"

@app.route('/getpointsForUser')
def api_hello():
	dic = {"username": "", "userPic": "", "totalPoints":0,"dailyPoints":[],"PushEvent":0,"PullRequestEvent":0,"IssueCommentEvent":0,"IssueEvent":0, "CommitEvent": 0}
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

			elif commitType == "IssuesEvent":
				points += 2
				dayPoints += 2
				dic["IssueEvent"] += 1
			elif commitType == "CommitEvent":
				points += 1
				dayPoints += 1
				dic["CommitEvent"] += 1
		print(points)	
		
		if dateStr in dailyPoints.keys():
			dailyPoints[dateStr] += dayPoints
		else: 
			dailyPoints[dateStr] = dayPoints 

	dic["totalPoints"] = points
	dic["dailyPoints"] = dailyPoints

	content = urllib.urlopen("https://github.com/users/%s/contributions" % user)
	contentTxt = content.read()
	print "=================================="
	print contentTxt
	print "=================================="
	lines = contentTxt.splitlines()
	lines = [x.strip() for x in lines]
	lines = [x for x in lines if x.startswith('<rect class="day"')]
	contribs = []
	offset = len("data-count=")
	for line in lines:
		idx = line.find("data-count=") + offset + 1
		line = line[idx:]
		parts = line.split('"')
		count = int(parts[0])
		date = datetime.strptime(parts[2], "%Y-%m-%d")
		contribs.append((count, date))

	cur = contribs.pop()
	while cur[1] >= datetime.today():
		cur = contribs.pop()  

	streak = 0
	while cur[0] != 0:
		streak += 1
		cur = contribs.pop()
	print "=================================="
	print streak
	print "=================================="

	dic["ContributionStreak"] = streak

	print dailyPoints
	print points
	return str(json.dumps(dic))

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)