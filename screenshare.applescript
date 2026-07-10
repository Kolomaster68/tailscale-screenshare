-- ponytail: reads the live tailnet each launch, so new Macs show up without editing anything
set ts to "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
set selfIP to do shell script ts & " ip -4"
set raw to do shell script ts & " status | awk -v me=" & selfIP & " '$4 == \"macOS\" && $1 != me {print $2 \"  (\" $1 \")\"}'"

if raw is "" then
	display alert "No other Macs found on your tailnet." message "Is Tailscale connected?"
	return
end if

set macs to paragraphs of raw
set choice to choose from list macs with title "Tailscale Screen Sharing" with prompt "Connect to:" default items {item 1 of macs}
if choice is false then return

set picked to item 1 of choice
set AppleScript's text item delimiters to {"(", ")"}
set targetIP to text item 2 of picked
do shell script "open vnc://" & targetIP
