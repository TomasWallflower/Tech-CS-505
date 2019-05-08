# Tech-CS-505
Controlling TECH internet module CS-505 and ST-505 on local LAN network

## Hardware description
TECH CS-505 and ST-505 is internet module compatible with boiler regulators TECH (except L-7 and L-8). This allows to set and watch boiler parameters remotely.
By default, the Internet module is controlled and set up via the web interface (http://zdalnie.techsterowniki.pl/ or www.emodul.pl) on the manufacturer's server. This connection is permanent and configuration is sent by server to internet module every few seconds. As far as I know, there is no API.

This is really not ideal, because in case of loss of internet connection, the module is working with latest configuration (temperatures, state of relay for pumps, etc.) and is not controllable anymore. Also the connection is not secured with SSL.

Fortunatelly, if you want or need to control this device over local LAN network, there is a CGI script built into module which can be operated with curl or similar software.

## Usage
When connecting the module to the network for the first time, it is necessary to access the IP address from the web browser and set the access name and password in the local web interface.

Then you can access CGI script on address:
`http://MODULE-LOCAL-IP/admin/cgi-bin/edition.cgi`

With curl the command will look for example like this:
`curl -s -u "USERNAME:PASSWORD" "http://MODULE-LOCAL-IP/admin/cgi-bin/edition.cgi" --data "gt=501"`
, where "gt" means GET and "501" means, that we're asking for central heating water temperature. Return value will be `501_630`, which means that central heating water temperature is 63°C.

In case you want to set any value (for example demanded central heating water temperature), you can use following command:
`curl -s -u "USERNAME:PASSWORD" "http://MODULE-LOCAL-IP/admin/cgi-bin/edition.cgi" --data "st=502_80"`, which means we want to set it to 80°C.

## Case of use
In file named CODES.txt there is full list of variables, supported by internet module.

In file named SCRIPT.sh there is linux shell script example which asks for values every 10 seconds and print them to console.
