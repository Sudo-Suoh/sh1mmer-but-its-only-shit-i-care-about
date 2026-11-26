## Shxmm3r
A modified version of sh1mmer where old payloads nobody cares about (cryptosmite, icarus, and calginosity) get deleted and payloads that matter stick around.
No hate to mercury workshops sh1mmer, this is probably worse

## Usage
here's some commands to run to build ts
```
sudo bash download.sh #type board
7z x board-legacy.zip
sudo bash builder.sh board.bin
sudo dd if=board.bin of=/dev/sdX status=progress
```
then you boot it

## Payloads
The orignal version as Pilot Bell Accurately put it "lobotomized sh1mmer" but this version is less lobotomized. (Hey I had 30 minutes there's only so much you can do within that time frame *especially as a skid like me*) so here are the payloads
* Quicksilver
* pivot_root #gonna be deleted next update for shimboot alpine utils
* placeholder shimboot payload
* credits
* touchdevmode
* usb and altfw enablement  #it fails for me but i think its supposed to do that because the same result happens for sh1mmer ill look into it for v1 dont mind it failing unless it doesnt get enabled
* set gbb flags (you can set it to anything :D)
* disable wp
* daub
* statewipe
* bash
Overall this is better then v0.90
## Plans for v1
 - [ ] Shimboot Alpine Boots with drivers
 - [ ] Internet works (no barla unless you can figure it out make a pr and ill add it)
 - [ ] Emhudroll Payload (does this payload make sense now it was gonna load on alpine the whole time)
 - [ ] Mrchromebox payload (sh1mmers mrchromebox is old there'll be offline chromebox payload for barla but the plan is to load it with alpine and download it)
 - [ ] Ability to Download Recovery Images
 - [ ] Ability to flash recovery images
 - [ ] Ability to auto detect exploits for board and version to unenroll
 - [ ] Protowrite
 - [ ] Emhudroll guided setup (an oobe kinda where it guides you)
 - [ ] reset kv to 1 payload (eh ts was supposed to be this update but honestly im ready to be done, also i alr commited everything theres no going back)
 - [ ] themes for shim (use frecon --clear option to set bg and use variables to set colors if this takes too long it will be pushed in another update named v1.0.1)
## NO MORE LOBOTIMIZED
yep it actually has more payloads and is actually kinda useful!
Suggest things in Issues and well... see you next update
## Credits
mercuryworkshop: og sh1mmer and sh1mmer payloads except ones with a credit here

DAUB by crosbreaker found by hannah

quicksilver by: emerwyi (idk discord bruh)

emudhroll by: katie

shimboot and pivot root shit by: ading2210 on github (idk discord bruh)

kristine for helping with an error

sudoh/evelyn: coding ts, kristine helped me with one error

sudoh is a skid bro :whale: (yes im calling myself a skid)

OlyB: making mrchromebox sh1mmer payload

**__if i forgot anyone make a github issue and ill credit you__**

crossystem: having esex with 13 year old while crossystem was 17

duck: being a goat and giving ideas that will be added on v1

also duck helped me w root a mount which this is huge for detecting version which will be needed im v1

crosbreaker: prebuilt sh1mmer shims used for download.sh
