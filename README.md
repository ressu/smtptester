Automated SMTP test for remote and local hosts
==============================================

As many others, this script scratches a personal itch. I had to test mail
delivery from multiple hosts and see whether delivery was possible with
unauthenticated and authenticated mails.

Since the script needs to run on many hosts and getting the script and their
components on the host is a issue that slows down testing. Also, I didn't want
to worry about passwords being stored on the remote hosts. That is why this
script is self contained and can be run over various hosts, directly over ssh
without copying any files over.

Requirements
------------

The script depends on wget, perl and bash. Other dependencies are from the
[smtp-cli](http://www.logix.cz/michal/devel/smtp-cli/) package, but are
generally installed on most hosts.

Running
-------

The cost of having a self contained script is that passwords need to be injected to the script somehow. I didn't want to create a wrapper script that injects the passwords in to the script, so editing the script is mandatory at this time.

You need to edit the usernames, passwords and various other bits and pieces at
the beginning of the script.

After that, running the script locally is pretty self explanatory:
```
bash smtptester.sh
```

Remote execution is just as straightforward:
```
ssh remotehost bash < smtptester.sh
```

Author
------

My itch has been scratched and I shared this script so that anyone who needs to accomplish the same can easily do just that.

If you need help or want to get in touch, drop me a note at:
 Sami Haahtinen <sami@badwolf.fi>
