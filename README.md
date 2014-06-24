INSTALL
--------------

```
git clone https://github.com/arunisrael/postal
bundle install
```

HOW TO RUN
--------------

Set up these environment variables using your own API keys + sandbox mail accounts
```
MAILGUN_API_USER
MAILGUN_API_KEY
MAILGUN_API_SEND_URI
MANDRILL_API_SEND_URI
MANDRILL_API_KEY
```


Here is an idea of what these should be set to:
```
MAILGUN_API_USER=api
MAILGUN_API_KEY=YOUR+MAILGUN+API+KEY
MAILGUN_API_SEND_URI=https://api.mailgun.net/v2/YOUR+MAILGUN+SANDBOX.mailgun.org/messages
MANDRILL_API_SEND_URI=https://mandrillapp.com/api/1.0/messages/send.json
MANDRILL_API_KEY=YOUR+MANDRILL+API+KEY
```

Then start the server:
```
ruby app.rb
```

Finally, try a CURL:
```
curl -X POST -H "application/json" -d '{    "to": "YOUR_EMAIL@gmail.com",    "to_name": "arun",    "from": "noreply@uber.com",    "from_name": "uber",    "subject": "a msg from uber",    "body": "<h1>your bill</h1><p> $10</p>"}' http://localhost:4567/email
```



LANGUAGE/FRAMEWORK CHOICE
--------------
Ruby/Sinatra because of my prior familiarity with the language/framework

TRADE-OFFS
--------------
The core app meets the requirements, but here is what I would do with more time:

- **Testing:** Add automated sinatra tests and clean up unit mailer tests
- **Code Coverage:** Provide insight into untested areas of the codebase
- **Job Queue:** Implement a job queue to store mails and have workers run to interact with the backend mailer APIs.
- **Rate Limiting:** Implement a front-end load balancer (nginx) to handle this
- **Authentication:** Add SSL support and token-based auth to validate mail requests
- **Adding New Mailers:** Further abstract mail provider API to easily allow addition of new mail providers. Can be done now by implement BaseMailer module methods
- **New Mail Fields:** Support bcc, cc, etc.
- **File Uploads/Attachments:** Set file type, size limits, etc
- **Delayed Delivery:** Hook up to mail provider API
- **Dynamic Provider Change:** Implement function to change default provider dynamically and utilize when error threshold is reached for current provider
- **Database storage for Messages:** Store messages in Database to support querying
- **Webhooks:** With stored messages, add api endpoints to allow webhooks for open/click actions

RUN THE TESTS
--------------
ruby Testfile
