# GET A Job

A Hypermedia Job Queue example

## A note about rails

This was generated with edge Rails. If you want to do the same, do this:

```
$ cd ~/src
$ git clone https://github.com/rails/rails.git
$ cd rails
$ rake install
$ gem build rails.gemspec # I had to build the meta-gem too...
$ gem install rails-4.0.0.beta.gem
$ cd ..
$ gem install rails-api
$ rails-api new get_a_job
```

The issue is that you can bundle edge rails with the app, but then the
generated app isn't with 4.0.0... There might be an easier way to do this, but
I thought it was pretty simple.

# Interacting with the Queue

The simplest way to add something is to do this:

```
$ curl -i -H "Accept: application/json" http://localhost:3000
HTTP/1.1 200 OK 
Link: <http://localhost:3000/profile>; rel="profile"
Content-Type: application/json; charset=utf-8
Etag: "c177410112a0887129017c8272c987e6"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: fa0b08e8-2e77-452c-851b-91c22c641ccb
X-Runtime: 0.003510
Content-Length: 64
Server: WEBrick/1.3.1 (Ruby/1.9.3/2012-02-16)
Date: Tue, 08 May 2012 20:51:24 GMT
Connection: Keep-Alive

{"job":{"status":null,"links":[{"href":"/jobs","rel":"index"}]}}
```

This lets us know we need a status attribute, and the href to push it to:


```
$ curl -i -H "Accept: application/json" -X POST -d "job[status]=in_progress" http://localhost:3000/jobs
HTTP/1.1 302 Found 
Location: http://localhost:3000/jobs/1
Link: <http://localhost:3000/profile>; rel="profile"
Content-Type: text/html; charset=utf-8
Cache-Control: no-cache
X-Request-Id: f3709bd8-961a-4091-b3cd-4841a08b5a85
X-Runtime: 0.012685
Content-Length: 94
Server: WEBrick/1.3.1 (Ruby/1.9.3/2012-02-16)
Date: Tue, 08 May 2012 20:00:53 GMT
Connection: Keep-Alive

<html><body>You are being <a href="http://localhost:3000/jobs/1">redirected</a>.</body></html>%                                                                 
```

Then you GET it:

```
$ curl -i -H "Accept: application/json" http://localhost:3000/jobs/1
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Link: <http://localhost:3000/profile>; rel="profile"
Etag: "1ab24154f124af6d36b0c65e126cabeb"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 10c304ed-1f9f-4362-895e-a896cf6f4e0d
X-Runtime: 0.004891
Content-Length: 47
Server: WEBrick/1.3.1 (Ruby/1.9.3/2012-02-16)
Date: Tue, 08 May 2012 20:08:28 GMT
Connection: Keep-Alive

{"job":{"status":"in_progress","links":[{"href":"/jobs/1","rel":"self"},{"href":"/jobs","rel":"index"}]}}
```

After ten seconds, you should see the status switch:

```
$ curl -i -H "Accept: application/json" http://localhost:3000/jobs/1
HTTP/1.1 200 OK 
Content-Type: application/json; charset=utf-8
Link: <http://localhost:3000/profile>; rel="profile"
Etag: "031eb7931004812303c6003c763f0272"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 1ae1f3d1-9644-4ad3-9782-4118e45fc741
X-Runtime: 0.002961
Content-Length: 44
Server: WEBrick/1.3.1 (Ruby/1.9.3/2012-02-16)
Date: Tue, 08 May 2012 20:09:10 GMT
Connection: Keep-Alive

{"job":{"status":"finished","links":[{"href":"/jobs/1","rel":"self"},{"href":"/jobs","rel":"index"}]}}
```
