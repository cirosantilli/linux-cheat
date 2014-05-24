#Send Emails Programmatically

Sending email from programs may be very difficult because anti spam measures that will block your naive attempts unless you configure everything properly.

This means that you will have to test all major email providers to see if for some reason their anti spam is not blocking your emails.

- Amazing client (desktop vs webmail vs mobile) statistics: https://litmus.com/blog/email-client-market-share-where-people-opened-in-2013/litmus-email-client-market-share-2013-infographic

    Key points: mobile rules.

It seems that gmail.com is far on the lead for email hosts.

Common pitfalls:

- try to do SMTP from blocked IP range. E.g.: trying to use Gmail SMTP from AWS address.

    Gmail simply prevents emails from going out because AWS IPs are all blacklisted.

    Alternative: use SES SMTP

- try do to AWS SES SMTP with From address as you@gmail.com

    Message will be sent, but falls under Gmail's spam because you don't have an SPF record. 

##Free methods

- AWS SES.

    2014-03, 1 year period, 200 emails / day.

    Require production usage increase. Takes max 1 day and is free.

- Google business, 1 month period.

#Email from your domain

To receive and send email from a domain you own, you can:

- set up an email server. You will have to keep it running and manage it.
- some registrars such as Godaddy provide an email forwarding service. This may be a simple solution if you do not expect very high reliability.

Gmail does not allow you to redirect a message as: me@gmail.com -> a@godaddy.com -> me.gmail.com: try with a different email address.

#MTA

Mail transfer agent.

#sendmail

Interface that comes in multiple packages such as SSMTP and postfix, so to configure it you must first determine which package provides it.

`sendmail` is an utility. Its interface is probably implemented by other packages because that utility was widely used.

May be symlink to an executable, or to the /etc/alternatives.

    echo "asdf" | sendmail

#mail

On Ubuntu a symlink to the alternatives system.

    echo -e "the message\n\nend of it" | mail -s "subject" -r "from@gmail.com" "to@gmail.com"
    mail -s "subject" -r "from@gmail.com" "to@gmail.com"

Mail ends in a line which contains a single dot `.` or ctrl+D.

#mailx

POSIX.

Does not seem to be used a lot, maybe because it does not have many capabilities.

#ssmtp

Simple SMTP.

Popular MTA. Really is simpler than Postfix to setup.

Configuration file:

vim /etc/ssmtp/ssmtp.conf

Configurations to send an email from gmail:

    Root=your_email@gmail.com
    Mailhub=smtp.gmail.com:465
    RewriteDomain=gmail.com
    AuthUser=your_gmail_username
    AuthPass=your_gmail_password
    FromLineOverride=Yes
    UseTLS=Yes

Now you can send emails from the command line as:

    printf 'Subject: sub\nBody' | ssmtp destination@mail.com
    printf 'Subject: sub\nBody' | sendmail destination@mail.com

The email will be sent from the email account you configured to send from.

#postfix

Main configuration file:

    cat /etc/postfix/main.cf

Postfix's `sendmail` does not show failure status immediately: it simply puts the email on a send queue.

This is probably done so that email sending does not block the current session, allowing in particular longer retry times.

To view the send queue, use `mailq`.

##mailq

Show email sending queue.

If delivery failed, explains why.

#mutt

Can send mail with attachment.

Curses inteface.

#send email from website

Sending email from a website may be nontrivial because of measures that must be taken to fight spam.

#spf

Sender Policy Framework.

Information that goes on the DNS for a host and says: hey, emails sent from IP XXX really come from this host, they are not span alright?

Required by most email services, or messages fall under spam.
