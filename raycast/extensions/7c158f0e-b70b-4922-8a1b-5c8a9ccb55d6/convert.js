"use strict";var pt=Object.create;var re=Object.defineProperty;var ht=Object.getOwnPropertyDescriptor;var mt=Object.getOwnPropertyNames;var gt=Object.getPrototypeOf,bt=Object.prototype.hasOwnProperty;var Ae=(t,e)=>(e=Symbol[t])?e:Symbol.for("Symbol."+t),Ee=t=>{throw TypeError(t)};var $t=(t,e)=>{for(var r in e)re(t,r,{get:e[r],enumerable:!0})},Fe=(t,e,r,a)=>{if(e&&typeof e=="object"||typeof e=="function")for(let s of mt(e))!bt.call(t,s)&&s!==r&&re(t,s,{get:()=>e[s],enumerable:!(a=ht(e,s))||a.enumerable});return t};var O=(t,e,r)=>(r=t!=null?pt(gt(t)):{},Fe(e||!t||!t.__esModule?re(r,"default",{value:t,enumerable:!0}):r,t)),yt=t=>Fe(re({},"__esModule",{value:!0}),t);var N=(t,e,r)=>{if(e!=null){typeof e!="object"&&typeof e!="function"&&Ee("Object expected");var a,s;r&&(a=e[Ae("asyncDispose")]),a===void 0&&(a=e[Ae("dispose")],r&&(s=a)),typeof a!="function"&&Ee("Object not disposable"),s&&(a=function(){try{s.call(this)}catch(i){return Promise.reject(i)}}),t.push([r,a,e])}else r&&t.push([r]);return e},_=(t,e,r)=>{var a=typeof SuppressedError=="function"?SuppressedError:function(n,c,d,l){return l=Error(d),l.name="SuppressedError",l.error=n,l.suppressed=c,l},s=n=>e=r?new a(n,e,"An error was suppressed during disposal"):(r=!0,n),i=n=>{for(;n=t.pop();)try{var c=n[1]&&n[1].call(n[2]);if(n[0])return Promise.resolve(c).then(i,d=>(s(d),i()))}catch(d){s(d)}if(r)throw e};return i()};var Dt={};$t(Dt,{default:()=>Ye});module.exports=yt(Dt);var $=require("@raycast/api"),Qe=require("react");var I=require("@raycast/api"),q=require("react/jsx-runtime");function ue(){return(0,q.jsxs)(I.ActionPanel.Section,{title:"Settings",children:[(0,q.jsx)(I.Action,{title:"Configure Command",icon:I.Icon.Gear,shortcut:{modifiers:["cmd","shift"],key:","},onAction:async()=>{await(0,I.openCommandPreferences)()}}),(0,q.jsx)(I.Action,{title:"Configure Extension",icon:I.Icon.Gear,shortcut:{modifiers:["opt","cmd"],key:","},onAction:async()=>{await(0,I.openExtensionPreferences)()}})]})}var m=require("child_process"),oe=require("fs"),v=O(require("path")),M=require("@raycast/api");var X=require("child_process"),S=require("@raycast/api");var Q=require("child_process"),w=O(require("fs")),C=O(require("os")),b=O(require("path")),o=require("@raycast/api");var j=O(require("react")),k=require("@raycast/api");var De=O(require("node:child_process")),Ue=require("node:buffer"),J=O(require("node:stream")),Oe=require("node:util");var Ne=require("react/jsx-runtime");var fe=globalThis;var ae=t=>!!t&&typeof t=="object"&&typeof t.removeListener=="function"&&typeof t.emit=="function"&&typeof t.reallyExit=="function"&&typeof t.listeners=="function"&&typeof t.kill=="function"&&typeof t.pid=="number"&&typeof t.on=="function",de=Symbol.for("signal-exit emitter"),he=class{constructor(){if(this.emitted={afterExit:!1,exit:!1},this.listeners={afterExit:[],exit:[]},this.count=0,this.id=Math.random(),fe[de])return fe[de];Object.defineProperty(fe,de,{value:this,writable:!1,enumerable:!1,configurable:!1})}on(e,r){this.listeners[e].push(r)}removeListener(e,r){let a=this.listeners[e],s=a.indexOf(r);s!==-1&&(s===0&&a.length===1?a.length=0:a.splice(s,1))}emit(e,r,a){if(this.emitted[e])return!1;this.emitted[e]=!0;let s=!1;for(let i of this.listeners[e])s=i(r,a)===!0||s;return e==="exit"&&(s=this.emit("afterExit",r,a)||s),s}},me=class{onExit(){return()=>{}}load(){}unload(){}},ge=class{#o;#t;#e;#s;#i;#n;#a;#r;constructor(e){this.#o=process.platform==="win32"?"SIGINT":"SIGHUP",this.#t=new he,this.#n={},this.#a=!1,this.#r=[],this.#r.push("SIGHUP","SIGINT","SIGTERM"),globalThis.process.platform!=="win32"&&this.#r.push("SIGALRM","SIGABRT","SIGVTALRM","SIGXCPU","SIGXFSZ","SIGUSR2","SIGTRAP","SIGSYS","SIGQUIT","SIGIOT"),globalThis.process.platform==="linux"&&this.#r.push("SIGIO","SIGPOLL","SIGPWR","SIGSTKFLT"),this.#e=e,this.#n={};for(let r of this.#r)this.#n[r]=()=>{let a=this.#e.listeners(r),{count:s}=this.#t,i=e;if(typeof i.__signal_exit_emitter__=="object"&&typeof i.__signal_exit_emitter__.count=="number"&&(s+=i.__signal_exit_emitter__.count),a.length===s){this.unload();let n=this.#t.emit("exit",null,r),c=r==="SIGHUP"?this.#o:r;n||e.kill(e.pid,c)}};this.#i=e.reallyExit,this.#s=e.emit}onExit(e,r){if(!ae(this.#e))return()=>{};this.#a===!1&&this.load();let a=r?.alwaysLast?"afterExit":"exit";return this.#t.on(a,e),()=>{this.#t.removeListener(a,e),this.#t.listeners.exit.length===0&&this.#t.listeners.afterExit.length===0&&this.unload()}}load(){if(!this.#a){this.#a=!0,this.#t.count+=1;for(let e of this.#r)try{let r=this.#n[e];r&&this.#e.on(e,r)}catch{}this.#e.emit=(e,...r)=>this.#l(e,...r),this.#e.reallyExit=e=>this.#c(e)}}unload(){this.#a&&(this.#a=!1,this.#r.forEach(e=>{let r=this.#n[e];if(!r)throw new Error("Listener not defined for signal: "+e);try{this.#e.removeListener(e,r)}catch{}}),this.#e.emit=this.#s,this.#e.reallyExit=this.#i,this.#t.count-=1)}#c(e){return ae(this.#e)?(this.#e.exitCode=e||0,this.#t.emit("exit",this.#e.exitCode,null),this.#i.call(this.#e,this.#e.exitCode)):0}#l(e,...r){let a=this.#s;if(e==="exit"&&ae(this.#e)){typeof r[0]=="number"&&(this.#e.exitCode=r[0]);let s=a.call(this.#e,e,...r);return this.#t.emit("exit",this.#e.exitCode,null),s}else return a.call(this.#e,e,...r)}},pe=null,wt=(t,e)=>(pe||(pe=ae(process)?new ge(process):new me),pe.onExit(t,e));function kt(t,{timeout:e}={}){let r=new Promise((c,d)=>{t.on("exit",(l,R)=>{c({exitCode:l,signal:R,timedOut:!1})}),t.on("error",l=>{d(l)}),t.stdin&&t.stdin.on("error",l=>{d(l)})}),a=wt(()=>{t.kill()});if(e===0||e===void 0)return r.finally(()=>a());let s,i=new Promise((c,d)=>{s=setTimeout(()=>{t.kill("SIGTERM"),d(Object.assign(new Error("Timed out"),{timedOut:!0,signal:"SIGTERM"}))},e)}),n=r.finally(()=>{clearTimeout(s)});return Promise.race([i,n]).finally(()=>a())}var be=class extends Error{constructor(){super("The output is too big"),this.name="MaxBufferError"}};function St(t){let{encoding:e}=t,r=e==="buffer",a=new J.default.PassThrough({objectMode:!1});e&&e!=="buffer"&&a.setEncoding(e);let s=0,i=[];return a.on("data",n=>{i.push(n),s+=n.length}),a.getBufferedValue=()=>r?Buffer.concat(i,s):i.join(""),a.getBufferedLength=()=>s,a}async function Ce(t,e){let r=St(e);return await new Promise((a,s)=>{let i=n=>{n&&r.getBufferedLength()<=Ue.constants.MAX_LENGTH&&(n.bufferedData=r.getBufferedValue()),s(n)};(async()=>{try{await(0,Oe.promisify)(J.default.pipeline)(t,r),a()}catch(n){i(n)}})(),r.on("data",()=>{r.getBufferedLength()>8e7&&i(new be)})}),r.getBufferedValue()}async function Re(t,e){t.destroy();try{return await e}catch(r){return r.bufferedData}}async function xt({stdout:t,stderr:e},{encoding:r},a){let s=Ce(t,{encoding:r}),i=Ce(e,{encoding:r});try{return await Promise.all([a,s,i])}catch(n){return Promise.all([{error:n,exitCode:null,signal:n.signal,timedOut:n.timedOut||!1},Re(t,s),Re(e,i)])}}function Pt(t){let e=typeof t=="string"?`
`:10,r=typeof t=="string"?"\r":13;return t[t.length-1]===e&&(t=t.slice(0,-1)),t[t.length-1]===r&&(t=t.slice(0,-1)),t}function Te(t,e){return t.stripFinalNewline?Pt(e):e}function vt({timedOut:t,timeout:e,signal:r,exitCode:a}){return t?`timed out after ${e} milliseconds`:r!=null?`was killed with ${r}`:a!=null?`failed with exit code ${a}`:"failed"}function It({stdout:t,stderr:e,error:r,signal:a,exitCode:s,command:i,timedOut:n,options:c,parentError:d}){let R=`Command ${vt({timedOut:n,timeout:c?.timeout,signal:a,exitCode:s})}: ${i}`,u=r?`${R}
${r.message}`:R,T=[u,e,t].filter(Boolean).join(`
`);return r?r.originalMessage=r.message:r=d,r.message=T,r.shortMessage=u,r.command=i,r.exitCode=s,r.signal=a,r.stdout=t,r.stderr=e,"bufferedData"in r&&delete r.bufferedData,r}function At({stdout:t,stderr:e,error:r,exitCode:a,signal:s,timedOut:i,command:n,options:c,parentError:d}){if(r||a!==0||s!==null)throw It({error:r,exitCode:a,signal:s,stdout:t,stderr:e,command:n,timedOut:i,options:c,parentError:d});return t}async function F(t,e,r){if(process.platform!=="darwin")throw new Error("AppleScript is only supported on macOS");let{humanReadableOutput:a,language:s,timeout:i,...n}=Array.isArray(e)?r||{}:e||{},c=a!==!1?[]:["-ss"];s==="JavaScript"&&c.push("-l","JavaScript"),Array.isArray(e)&&c.push("-",...e);let d=De.default.spawn("osascript",c,{...n,env:{PATH:"/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"}}),l=kt(d,{timeout:i??1e4});d.stdin.end(t);let[{error:R,exitCode:u,signal:T,timedOut:Z},D,U]=await xt(d,{encoding:"utf8"},l),ee=Te({stripFinalNewline:!0},D),te=Te({stripFinalNewline:!0},U);return At({stdout:ee,stderr:te,error:R,exitCode:u,signal:T,timedOut:Z,command:"osascript",options:r,parentError:new Error})}var _e=async()=>F(`use framework "AppKit"
      use framework "PDFKit"
      
      set pb to current application's NSPasteboard's generalPasteboard()
      set theItems to pb's readObjectsForClasses:({current application's NSURL, current application's NSImage, current application's NSAttributedString}) options:{}
      
      set theImages to {}
      repeat with i from 0 to ((theItems's |count|()) - 1)
        set theItem to (theItems's objectAtIndex:i)
        if (theItem's |class|()) is current application's NSImage then
          copy theItem to end of theImages
        else if (theItem's |class|()) is current application's NSURL then
          if (theItem's absoluteString() as text) ends with ".pdf" then
            set theImage to (current application's PDFDocument's alloc()'s initWithURL:theItem)
          else
            set theImage to (current application's NSImage's alloc()'s initWithContentsOfURL:theItem)
          end if
          if theImage is not missing value then
            copy theImage to end of theImages
          end if
        else if (theItem's |class|()) is current application's NSConcreteAttributedString then
          repeat with i from 0 to ((theItem's |length|()) - 1)
            set attrs to (theItem's attributesAtIndex:i longestEffectiveRange:(missing value) inRange:{i, (theItem's |length|()) - i})
            set theAttachment to (attrs's objectForKey:"NSAttachment")
            if theAttachment is not missing value then
              set cell to theAttachment's attachmentCell()
              set theImage to cell's image()
              copy theImage to end of theImages
            end if
          end repeat
        end if
      end repeat
      
      set tempDir to current application's NSTemporaryDirectory() as text
      set filePaths to {}
      repeat with i from 1 to count theImages
        set theImage to item i of theImages
        set theFile to tempDir & "clipboardImage_" & i
        if theImage's |class|() is current application's PDFDocument then
          set theFile to theFile & ".pdf"
          (theImage's writeToFile:theFile)
        else
          set theFile to theFile & ".png"
          set theTIFFData to theImage's TIFFRepresentation()
          set theBitmap to (current application's NSBitmapImageRep's alloc()'s initWithData:theTIFFData)
          set thePNGData to (theBitmap's representationUsingType:(current application's NSBitmapImageFileTypePNG) |properties|:(current application's NSDictionary's alloc()'s init()))
          (thePNGData's writeToFile:theFile atomically:false)
        end if
        copy theFile to end of filePaths
      end repeat
      
      return filePaths`),Le=async t=>{let e=Array.isArray(t)?t:[t];await F(`use framework "Foundation"
      use framework "PDFKit"
      use scripting additions
  
      set thePasteboard to current application's NSPasteboard's generalPasteboard()
      thePasteboard's clearContents()
      
      -- Handle PDFs separately
      set pdfPaths to {"${e.filter(r=>r.endsWith(".pdf")).join('", "')}"}
  
      set pdfItems to current application's NSMutableArray's alloc()'s init()
      repeat with pdfPath in pdfPaths
        if length of pdfPath is not 0 then
          set pdfItem to current application's NSPasteboardItem's alloc()'s init()
          set pdfData to current application's NSData's dataWithContentsOfFile:pdfPath
          pdfItem's setData:pdfData forType:(current application's NSPasteboardTypePDF)
          pdfItems's addObject:pdfItem
        end if
      end repeat
  
      if pdfItems's |count|() > 0 then
        thePasteboard's writeObjects:pdfItems
      end if
        
      -- Handle all other image types
      set theFiles to {"${e.join('", "')}"}
    
      set theImages to {}
      repeat with theFile in theFiles
        if length of theFile is not 0 then
          set theImage to (current application's NSImage's alloc()'s initWithContentsOfFile:theFile)
          if theImage is not missing value then
            copy theImage to end of theImages
          end if
        end if
      end repeat
      
      if (count theImages) > 0 then
        thePasteboard's writeObjects:theImages
      end if`)};var z=O(require("path"));var ne=require("child_process");function V(t,e){let r=e?.command,a=e?.language,s=[...e?.leadingArgs?.map(u=>u.toString())||[]],i=e?.trailingArgs||[];!r&&(a===void 0||a==="AppleScript"||a==="JXA")&&(r="/usr/bin/osascript",s.push("-l",a==="JXA"?"JavaScript":"AppleScript",...t.startsWith("/")?[]:["-e"],t,...i.map(u=>u.toString())));let n=process.env;if(e?.command&&(n.PATH=`${n.PATH}:${(0,ne.execSync)(`$(/bin/bash -lc 'echo $SHELL') -lc 'echo "$PATH"'`).toString()}`,r=e.command,s.push(t,...i.map(u=>u.toString()))),!r)throw new Error("No command specified.");let c="",d=u=>{console.log(u)},l=(0,ne.spawn)(r,s,{env:n});return e?.logDebugMessages&&console.log(`Running shell command "${r} ${s.join(" ")}"`),l.stdout?.on("data",u=>{c+=u.toString(),e?.logIntermediateOutput&&console.log(`Data from script: ${c}`)}),l.stderr?.on("data",u=>{e?.stderrCallback&&e.stderrCallback(u.toString()),e?.logErrors&&console.error(u.toString())}),l.stdin.on("error",u=>{e?.logErrors&&console.error(`Error writing to stdin: ${u}`)}),d=async u=>{u?.length>0&&(l.stdin.cork(),l.stdin.write(`${u}\r
`),process.nextTick(()=>l.stdin.uncork()),e?.logSentMessages&&console.log(`Sent message: ${u}`))},{data:(async()=>new Promise((u,T)=>{let Z=e?.timeout?setTimeout(()=>{try{l.kill()}catch(D){e?.logErrors&&console.error(`Error killing process: ${D}`)}return e?.logErrors&&console.error("Script timed out"),l.stdin.end(),l.kill(),T("Script timed out")},e?.timeout):void 0;l.on("close",D=>{if(D!==0)return e?.logErrors&&console.error(`Script exited with code ${D}`),l.stdin.end(),l.kill(),T(`Script exited with code ${D}`);clearTimeout(Z);let U;try{U=JSON.parse(c)}catch{U=c.trim()}return e?.logFinalOutput&&console.log(`Script output: ${U}`),u(U)})}))(),sendMessage:d}}var B=require("@raycast/api");function L(t){return t.split(", /").map((e,r)=>r===0?e.trim():`/${e.trim()}`)}async function Me(){let t=z.default.join(B.environment.assetsPath,"scripts","finder.scpt"),e=await V(t,{language:"AppleScript",stderrCallback:r=>P("Finder Selection Error",new Error(r))}).data;return Array.isArray(e)?e:L(e)}async function We(){let t=z.default.join(B.environment.assetsPath,"scripts","houdahSpot.scpt"),e=await V(t,{language:"AppleScript",stderrCallback:r=>P("HoudahSpot Selection Error",new Error(r))}).data;return Array.isArray(e)?e:L(e)}async function je(){let t=z.default.join(B.environment.assetsPath,"scripts","neofinder.scpt"),e=await V(t,{language:"AppleScript",stderrCallback:r=>P("NeoFinder Selection Error",new Error(r))}).data;return Array.isArray(e)?e:L(e)}async function Ve(){let t=z.default.join(B.environment.assetsPath,"scripts","pathfinder.scpt"),e=await V(t,{language:"JXA",stderrCallback:r=>P("Path Finder Selection Error",new Error(r))}).data;return Array.isArray(e)?e:L(e)}async function ze(){let t=z.default.join(B.environment.assetsPath,"scripts","qspace.scpt"),e=await V(t,{language:"JXA",stderrCallback:r=>P("QSpace Pro Selection Error",new Error(r))}).data;return Array.isArray(e)?e:L(e)}async function Be(){let t=z.default.join(B.environment.assetsPath,"scripts","forklift-beta.scpt"),e=await V(t,{language:"JXA",stderrCallback:r=>P("ForkLift Selection Error",new Error(r))}).data;return Array.isArray(e)?e:L(e)}var se=async t=>{let e=await o.LocalStorage.getItem("itemsToRemove")??"";await o.LocalStorage.setItem("itemsToRemove",e+`
`+t)},H=async(t,e)=>{let r=b.default.join(C.tmpdir(),`${t}.${e}`);return{path:r,[Symbol.asyncDispose]:async()=>{w.existsSync(r)&&await w.promises.rm(r,{recursive:!0})}}};var Ge=async()=>{let e=(await o.LocalStorage.getItem("itemsToRemove")??"").toString().split(`
`).filter(Boolean);for(let r of e)w.existsSync(r)&&await w.promises.rm(r,{recursive:!0});await o.LocalStorage.removeItem("itemsToRemove")},$e=async()=>{let t=[],r=(0,o.getPreferenceValues)().inputMethod,a=!1;if(r=="Clipboard")try{let n=L(await _e());if(await o.LocalStorage.setItem("itemsToRemove",n.join(`
`)),n.filter(c=>c.trim().length>0).length>0)return n}catch(n){console.error(`Couldn't get images from clipboard: ${n}`),a=!0}let s=r;try{s=(await(0,o.getFrontmostApplication)()).name}catch(n){console.error(`Couldn't get frontmost application: ${n}`)}try{(r=="Path Finder"||s=="Path Finder")&&(t=await Ve())}catch(n){console.error(`Couldn't get images from Path Finder: ${n}`),a=!0}try{(r=="NeoFinder"||s=="NeoFinder")&&(t=await je())}catch(n){console.error(`Couldn't get images from NeoFinder: ${n}`),a=!0}try{(r=="HoudahSpot"||s=="HoudahSpot")&&(t=await We())}catch(n){console.error(`Couldn't get images from HoudahSpot: ${n}`),a=!0}try{(r=="QSpace"||s=="QSpace Pro"||s=="QSpace")&&(t=await ze())}catch(n){console.error(`Couldn't get images from ${s}: ${n}`),a=!0}try{(r=="ForkLift"||s=="ForkLift")&&(t=await Be())}catch(n){console.error(`Couldn't get images from ForkLift: ${n}`),a=!0}if(t.length>0)return t.filter((n,c)=>t.indexOf(n)===c);let i=await Me();return s=="Finder"||r=="Finder"||a?t=i:i.forEach(n=>{n.split("/").at(-2)=="Desktop"&&!t.includes(n)&&t.push(n)}),t.filter((n,c)=>t.indexOf(n)===c)},Je=async t=>{let e="Finder";try{e=(await(0,o.getFrontmostApplication)()).name}catch(a){console.error(`Couldn't get frontmost application: : ${a}`)}let r=(0,o.getPreferenceValues)();r.imageResultHandling=="copyToClipboard"?(await Le(t),He(t)):r.imageResultHandling=="openInPreview"?(await Et(t),He(t)):r.inputMethod=="NeoFinder"||e=="NeoFinder"?await(0,o.showInFinder)(t[0]):(r.inputMethod=="HoudahSpot"||e=="HoudahSpot")&&await(0,o.showInFinder)(t[0])},ie=async()=>(C.cpus()[0].model.includes("Apple")?"arm":"x86")=="arm"?((0,Q.execSync)(`chmod +x ${o.environment.assetsPath}/webp/arm/dwebp`),(0,Q.execSync)(`chmod +x ${o.environment.assetsPath}/webp/arm/cwebp`),w.existsSync(`${o.environment.assetsPath}/webp/x86/dwebp`)&&await w.promises.rm(`${o.environment.assetsPath}/webp/x86/dwebp`),w.existsSync(`${o.environment.assetsPath}/webp/x86/cwebp`)&&await w.promises.rm(`${o.environment.assetsPath}/webp/x86/cwebp`),[`${o.environment.assetsPath}/webp/arm/dwebp`,`${o.environment.assetsPath}/webp/arm/cwebp`]):((0,Q.execSync)(`chmod +x ${o.environment.assetsPath}/webp/x86/dwebp`),(0,Q.execSync)(`chmod +x ${o.environment.assetsPath}/webp/x86/cwebp`),w.existsSync(`${o.environment.assetsPath}/webp/arm/dwebp`)&&await w.promises.rm(`${o.environment.assetsPath}/webp/arm/dwebp`),w.existsSync(`${o.environment.assetsPath}/webp/arm/cwebp`)&&await w.promises.rm(`${o.environment.assetsPath}/webp/arm/cwebp`),[`${o.environment.assetsPath}/webp/x86/dwebp`,`${o.environment.assetsPath}/webp/x86/cwebp`]);var ye=async(t,e,r)=>F(`use framework "Foundation"
  use scripting additions

  -- Load SVG image from file
  set svgFilePath to "${e}"
  set svgData to current application's NSData's alloc()'s initWithContentsOfFile:svgFilePath
  
  -- Create image from SVG data
  set svgImage to current application's NSImage's alloc()'s initWithData:svgData
  
  -- Convert image to PNG data
  set tiffData to svgImage's TIFFRepresentation()
  set theBitmap to current application's NSBitmapImageRep's alloc()'s initWithData:tiffData

  try
    set pngData to theBitmap's representationUsingType:(current application's NSBitmapImageFileType${t}) |properties|:(missing value)
  on error
    set pngData to theBitmap's representationUsingType:(current application's NSBitmapImageFileTypePNG) |properties|:(missing value)
  end
  
  -- Save PNG data to file
  pngData's writeToFile:"${r}" atomically:false`),Y=async(t,e,r)=>{let a=(0,o.getPreferenceValues)(),s="NSPNGFileType";return t=="JPEG"?s="NSJPEGFileType":t=="TIFF"&&(s="NSTIFFFileType"),F(`use framework "Foundation"
  use framework "PDFKit"
  
  -- Load the PDF file as NSData
  set pdfData to current application's NSData's dataWithContentsOfFile:"${e}"
  
  -- Create a PDFDocument from the PDF data
  set pdfDoc to current application's PDFDocument's alloc()'s initWithData:pdfData

  ${a.imageResultHandling=="copyToClipboard"||a.imageResultHandling=="openInPreview"?"set pageImages to current application's NSMutableArray's alloc()'s init()":""}
  
  set pageCount to (pdfDoc's pageCount()) - 1
  repeat with pageIndex from 0 to pageCount
    -- Create an NSImage from each page of the PDF document
    set pdfPage to (pdfDoc's pageAtIndex:pageIndex)
    set pdfRect to (pdfPage's boundsForBox:(current application's kPDFDisplayBoxMediaBox))
    set pdfImage to (current application's NSImage's alloc()'s initWithSize:{item 1 of item 2 of pdfRect, item 2 of item 2 of pdfRect})
    pdfImage's lockFocus()
    (pdfPage's drawWithBox:(current application's kPDFDisplayBoxMediaBox))
    pdfImage's unlockFocus()

    ${a.imageResultHandling=="copyToClipboard"?"pageImages's addObject:pdfImage":`
  
    -- Convert the NSImage to PNG data
    set pngData to pdfImage's TIFFRepresentation()
    set pngRep to (current application's NSBitmapImageRep's imageRepWithData:pngData)
    set pngData to (pngRep's representationUsingType:(current application's ${s}) |properties|:(missing value))
    
    -- Write the PNG data to a new file
    set filePath to "${r}/page-" & pageIndex + 1 & ".${t.toLowerCase()}"
    set fileURL to current application's NSURL's fileURLWithPath:filePath
    ${a.imageResultHandling=="openInPreview"?"pageImages's addObject:fileURL":""}
    pngData's writeToURL:fileURL atomically:false`}
  end repeat

  ${a.imageResultHandling=="openInPreview"?`
    -- Open the images of each page in Preview, then delete their temporary files
    tell application "Finder"
      set previewPath to POSIX path of ((application file id "com.apple.Preview") as text)
      set previewURL to current application's NSURL's fileURLWithPath:previewPath
    end tell

    set workspace to current application's NSWorkspace's sharedWorkspace()
    set config to current application's NSWorkspaceOpenConfiguration's configuration()
    workspace's openURLs:pageImages withApplicationAtURL:previewURL configuration:config completionHandler:(missing value)
    delay 1
    
    set fileManager to current application's NSFileManager's defaultManager()
    repeat with imageURL in pageImages
      fileManager's removeItemAtURL:imageURL |error|:(missing value)
    end repeat
    `:""}
  
  ${a.imageResultHandling=="copyToClipboard"?`
    -- Copy the image of each page to the clipboard
    set thePasteboard to current application's NSPasteboard's generalPasteboard()
    thePasteboard's clearContents()
    thePasteboard's writeObjects:pageImages`:""}`,{timeout:60*1e3*5})};var Et=async t=>{let e=Array.isArray(t)?t:[t],r=e.some(a=>b.default.extname(a)==".svg");await F(`use framework "Foundation"
    use scripting additions
    set pageImages to {${e.map(a=>`current application's NSURL's fileURLWithPath:"${a}"`).join(", ")}}

    set workspace to current application's NSWorkspace's sharedWorkspace()
    set config to current application's NSWorkspaceOpenConfiguration's configuration()

    ${r?`tell application "Finder"
            set safariPath to POSIX path of ((application file id "com.apple.Safari") as text)
            set safariURL to current application's NSURL's fileURLWithPath:safariPath
          end tell

          workspace's openURLs:pageImages withApplicationAtURL:safariURL configuration:config completionHandler:(missing value)
          
          tell application "Safari"
            set finished to false
            set iter to 0
            repeat while ((count of windows) = 0 or finished is not true) and iter < 10
              delay 0.5
              set iter to iter + 1

              set currentStatus to true
              repeat with doc in (path of documents as list)
                repeat with thePath in {"${e.map(a=>encodeURI(`file://${a}`)).join('", "')}"}
                  if thePath is not in doc then
                    set currentStatus to false
                  end if
                end repeat
              end repeat
              set finished to currentStatus
            end repeat
          end tell
          `:`tell application "Finder"
            set previewPath to POSIX path of ((application file id "com.apple.Preview") as text)
            set previewURL to current application's NSURL's fileURLWithPath:previewPath
          end tell

          workspace's openURLs:pageImages withApplicationAtURL:previewURL configuration:config completionHandler:(missing value)
          
          tell application "Preview"
            set finished to false
            set iter to 0
            repeat while ((count of windows) = 0 or finished is not true) and iter < 10
              delay 0.5
              set iter to iter + 1

              set currentStatus to true
              repeat with doc in (path of documents as list)
                repeat with thePath in {"${e.join('", "')}"}
                  if thePath is not in doc then
                    set currentStatus to false
                  end if
                end repeat
              end repeat
              set finished to currentStatus
            end repeat
          end tell`}`)},He=t=>{let e=Array.isArray(t)?t:[t];for(let r of e)w.unlinkSync(r)},Ft=async()=>F(`use framework "Foundation"
    use scripting additions
    set workspace to current application's NSWorkspace's sharedWorkspace()
    set runningApps to workspace's runningApplications()
    
    set targetApp to missing value
    repeat with theApp in runningApps
      if theApp's ownsMenuBar() then
        set targetApp to theApp
        exit repeat
      end if
    end repeat
    
    if targetApp is missing value then
      return "Finder"
    else
      return targetApp's localizedName() as text
    end if`),Ct=async t=>{let e="Finder";try{e=await Ft()}catch(r){console.error(`Couldn't get frontmost application: ${r}`)}try{if(e=="Path Finder")return F(`tell application "Path Finder"
        if 1 \u2264 (count finder windows) then
          try
          get POSIX path of (target of finder window 1)
          on error message number -1728
            -- Folder is nonstandard, use container of selection
            tell application "System Events"
              set itemPath to POSIX file "${t}" as alias
              return POSIX path of container of itemPath
            end tell
          end try
        else
          get POSIX path of desktop
        end if
      end tell`)}catch(r){console.error(`Couldn't get current directory of Path Finder: ${r}`)}return F(`tell application "Finder"
    if 1 \u2264 (count Finder windows) then
      try
        return POSIX path of (target of window 1 as alias)
      on error message number -1700
        -- Folder is nonstandard, use container of selection
        set itemPath to POSIX file "${t}" as alias
        return POSIX path of (container of itemPath as alias)
      end try
    else
      return POSIX path of (desktop as alias)
    end if
  end tell`)},Ke=async(t,e=!1,r=void 0)=>{let a=(0,o.getPreferenceValues)(),s=await Ct(t[0]);return t.map(i=>{let n=i;if(a.imageResultHandling=="saveToDownloads"?n=b.default.join(C.homedir(),"Downloads",b.default.basename(n)):a.imageResultHandling=="saveToDesktop"?n=b.default.join(C.homedir(),"Desktop",b.default.basename(n)):(a.imageResultHandling=="saveInContainingFolder"||a.imageResultHandling=="replaceOriginal")&&(a.inputMethod=="Clipboard"||e)?n=b.default.join(s,b.default.basename(n)):(a.imageResultHandling=="copyToClipboard"||a.imageResultHandling=="openInPreview")&&(n=b.default.join(C.tmpdir(),b.default.basename(n))),n=r?n.replace(b.default.extname(n),`.${r}`):n,a.imageResultHandling!="replaceOriginal"&&C.tmpdir()!=b.default.dirname(n)){let c=2;for(;w.existsSync(n);)n=b.default.join(b.default.dirname(n),b.default.basename(n,b.default.extname(n))+`-${c}${b.default.extname(n)}`),c++}return n})},P=async(t,e,r,a)=>{console.error(e),r?(r.title=t,r.message=a??e.message,r.style=o.Toast.Style.Failure,r.primaryAction={title:"Copy Error",onAction:async()=>{await o.Clipboard.copy(e.message)}}):r=await(0,o.showToast)({title:t,message:a??e.message,style:o.Toast.Style.Failure,primaryAction:{title:"Copy Error",onAction:async()=>{await o.Clipboard.copy(e.message)}}})};var Xe=t=>{let e=C.homedir();if(t.startsWith("~"))return t.replace(/^~(?=$|\/|\\)/,e);let r=/(\/Users\/.*?)\/.*/,a=t.match(r);return a?t.replace(a[1],e):t};var Ze=require("fs");async function Rt(){let t="";try{t=(0,X.execSync)(`/bin/zsh -lc 'realpath "$(which brew)"'`).toString().trim()}catch(e){console.error(e)}if(t==="")return await(0,S.showToast)({title:"Homebrew is required to install the AVIF encoder.",message:"Please install Homebrew and try again. Visit https://brew.sh for more information. Once Homebrew is installed, run the command `brew install libavif` to install the AVIF encoder manually (Otherwise, this command will be run automatically).",style:S.Toast.Style.Failure}),!1;if(await(0,S.confirmAlert)({title:"Install AVIF Encoder",message:"The libavif Homebrew formula is required to convert images to/from AVIF format. Would you like to install it now?",primaryAction:{title:"Install"}})){let e=await(0,S.showToast)({title:"Installing AVIF Encoder...",style:S.Toast.Style.Animated});try{if((0,X.execSync)(`/bin/zsh -ilc '${t} install --quiet libavif || true'`),!Tt())throw new Error("The avifenc binary has not been added to the user's $PATH");return e.title="AVIF Encoder installed successfully!",e.style=S.Toast.Style.Success,!0}catch(r){console.error(r),P("Failed to install AVIF Encoder.",r,e,"If you previously attempted to install libavif or avifenc, please run `brew doctor` followed by `brew cleanup` and try again.")}}return await(0,S.showToast)({title:"AVIF Encoder not installed.",style:S.Toast.Style.Failure}),!1}async function Tt(){let r=!1,a=0;for(;!r&&a<7;){let s=(0,X.execSync)("/bin/zsh -lc 'command -v avifenc'").toString().trim();if((0,Ze.existsSync)(s)){r=!0;break}await new Promise(i=>setTimeout(i,1e3)),a++}return r}async function K(){let t=await S.LocalStorage.getItem("avifEncoderPath"),e=await S.LocalStorage.getItem("avifDecoderPath");if(!t||!e)try{t=(0,X.execSync)(`/bin/zsh -lc 'realpath "$(which avifenc)"'`).toString().trim(),e=(0,X.execSync)(`/bin/zsh -lc 'realpath "$(which avifdec)"'`).toString().trim()}catch(r){if(await Rt())try{return await K()}catch(a){console.error(a),P("AVIF Encoder not found.",a,void 0,"Please install the libavif Homebrew formula manually and try again.")}else P("AVIF Encoder not found.",r,void 0,"Please install the libavif Homebrew formula and try again.")}return{encoderPath:t,decoderPath:e}}var qe=["ASTC","AVIF","BMP","DDS","EXR","GIF","HEIC","HEICS","ICNS","ICO","JPEG","JP2","KTX","PBM","PDF","PNG","PSD","PVR","TGA","TIFF","WEBP","SVG"];async function W(t,e,r,a=!1){let s=(0,M.getPreferenceValues)();M.environment.commandName==="tools/convert-images"&&(s.jpegExtension="jpg");let i=[],n=t.map(le=>Xe(le));for(let[le,y]of n.entries()){let E=v.default.extname(y).slice(1),dt=e==="JPEG"?s.jpegExtension:e.toLowerCase(),h=r?.[le]||(await Ke([y],!1,dt))[0];if(e==="WEBP"&&E.toLowerCase()!=="svg"){let[,p]=await ie();if(E.toLowerCase()=="avif"){var c=[];try{let{decoderPath:f}=await K();let x=N(c,await H("tmp","png"),!0);(0,m.execSync)(`${f} '${y}' '${x.path}'`);(0,m.execSync)(`${p} ${s.useLosslessConversion?"-lossless":""} '${x.path}' -o '${h}'`)}catch(d){var l=d,R=!0}finally{var u=_(c,l,R);u&&await u}}else if(E.toLowerCase()=="pdf"){let f=v.default.join(h.split("/").slice(0,-1).join("/"),v.default.basename(h,".webp")+" WebP");(0,m.execSync)(`mkdir -p '${f}'`),await Y("PNG",y,f);let x=(0,oe.readdirSync)(f).map(g=>v.default.join(f,g));for(let g of x)(0,m.execSync)(`${p} ${s.useLosslessConversion?"-lossless":""} '${g}' -o '${g.replace(".png",".webp")}'`),await se(g)}else(0,m.execSync)(`${p} ${s.useLosslessConversion?"-lossless":""} '${y}' -o '${h}'`)}else if(E.toLowerCase()=="svg")if(["AVIF","PDF","WEBP"].includes(e)){var T=[];try{let p=N(T,await H("tmp","png"),!0);await ye("PNG",y,p.path);return await W([p.path],e,[h])}catch(Z){var D=Z,U=!0}finally{var ee=_(T,D,U);ee&&await ee}}else return await ye(e,y,h),await W([h],e,[h]);else if(e=="SVG"){var ke=[];try{let p=N(ke,await H("tmp","bmp"),!0);(0,m.execSync)(`chmod +x ${M.environment.assetsPath}/potrace/potrace`);if(E.toLowerCase()=="webp"){var te=[];try{let f=N(te,await H("tmp","png"),!0);let[x]=await ie();(0,m.execSync)(`${x} '${y}' -o '${f.path}'`);(0,m.execSync)(`sips --setProperty format "bmp" '${f.path}' --out '${p.path}' && ${M.environment.assetsPath}/potrace/potrace -s --tight -o '${h}' '${p.path}'`)}catch(et){var tt=et,rt=!0}finally{var we=_(te,tt,rt);we&&await we}}else if(E.toLowerCase()=="pdf"){let f=v.default.join(h.split("/").slice(0,-1).join("/"),v.default.basename(h,".svg")+" SVG");(0,m.execSync)(`mkdir -p '${f}'`),await Y("PNG",y,f);let x=(0,oe.readdirSync)(f).map(g=>v.default.join(f,g));for(let g of x)(0,m.execSync)(`sips --setProperty format "bmp" '${g}' --out '${p.path}' && ${M.environment.assetsPath}/potrace/potrace -s --tight -o '${g.replace(".png",".svg")}' '${p.path}'`),await se(g)}else(0,m.execSync)(`sips --setProperty format "bmp" '${y}' --out '${p.path}' && ${M.environment.assetsPath}/potrace/potrace -s --tight -o '${h}' '${p.path}'`)}catch(at){var nt=at,st=!0}finally{var Se=_(ke,nt,st);Se&&await Se}}else if(e=="AVIF"){let{encoderPath:p}=await K();if(E.toLowerCase()=="pdf"){let f=v.default.join(h.split("/").slice(0,-1).join("/"),v.default.basename(h,".avif")+" AVIF");(0,m.execSync)(`mkdir -p '${f}'`),await Y("PNG",y,f);let x=(0,oe.readdirSync)(f).map(g=>v.default.join(f,g)).filter(g=>g.endsWith(".png"));for(let g of x)(0,m.execSync)(`${p} ${s.useLosslessConversion?"-s 0 --min 0 --max 0 --minalpha 0 --maxalpha 0 --qcolor 100 --qalpha 100 ":""}'${g}' '${g.replace(".png",".avif")}'`),await se(g)}else{var xe=[];try{let f=N(xe,await H("tmp","png"),!0);await W([y],"PNG",[f.path],!0);(0,m.execSync)(`${p} ${s.useLosslessConversion?"-s 0 --min 0 --max 0 --minalpha 0 --maxalpha 0 --qcolor 100 --qalpha 100 ":""}'${f.path}' '${h}'`)}catch(it){var ot=it,ct=!0}finally{var Pe=_(xe,ot,ct);Pe&&await Pe}}}else if(E.toLowerCase()=="webp"){let[p]=await ie();(0,m.execSync)(`${p} '${y}' -o '${h}'`),(0,m.execSync)(`sips --setProperty format ${e.toLowerCase()} '${h}'`)}else if(E.toLowerCase()=="pdf"){let p=v.default.basename(y),f=`${p?.substring(0,p.lastIndexOf("."))} ${e}`,x=v.default.join(h.split("/").slice(0,-1).join("/"),f);(0,m.execSync)(`mkdir -p '${x}'`),await Y(e,y,x)}else if(E.toLowerCase()=="avif"){var ve=[];try{let{decoderPath:p}=await K();let f=N(ve,await H("tmp","png"),!0);(0,m.execSync)(`${p} '${y}' '${f.path}'`);return await W([f.path],e,[h])}catch(lt){var ut=lt,ft=!0}finally{var Ie=_(ve,ut,ft);Ie&&await Ie}}else(0,m.execSync)(`sips --setProperty format ${e.toLowerCase()} '${y}' --out '${h}'`);i.push(h)}return a||await Je(i),i}var G=require("@raycast/api");async function ce(t){if(t.selectedImages.length===0||t.selectedImages.length===1&&t.selectedImages[0]===""){await(0,G.showToast)({title:"No images selected",message:"No images found in your selection. Make sure the image(s) still exist on the disk. Verify that Raycast has permission to automate Finder and/or third-party file managers under System Settings->Privacy & Security->Automation->Raycast. If using a third-party file manager, make sure the app's index is up to date.",style:G.Toast.Style.Failure});return}let e=await(0,G.showToast)({title:t.inProgressMessage,style:G.Toast.Style.Animated}),r=`image${t.selectedImages.length===1?"":"s"}`;try{let a=await t.operation();return e.title=`${t.successMessage} ${t.selectedImages.length.toString()} ${r}`,e.style=G.Toast.Style.Success,a}catch(a){await P(`${t.failureMessage} ${t.selectedImages.length.toString()} ${r}`,a,e)}finally{await Ge()}}var A=require("react/jsx-runtime");function Ye(t){let e=(0,$.getPreferenceValues)(),r=qe.filter(a=>e[`show${a}`]);return(0,Qe.useEffect)(()=>{if(t.launchContext&&"convertTo"in t.launchContext){let{convertTo:a}=t.launchContext;a&&Promise.resolve($e()).then(async s=>{await ce({operation:()=>W(s,a),selectedImages:s,inProgressMessage:"Conversion in progress...",successMessage:"Converted",failureMessage:"Failed to convert"})})}},[t.launchContext]),(0,A.jsxs)($.List,{searchBarPlaceholder:"Search image transformations...",children:[(0,A.jsx)($.List.EmptyView,{title:"No Formats Enabled",description:"Enable formats in the command preferences (\u2318\u21E7,)",icon:$.Icon.Image,actions:(0,A.jsx)($.ActionPanel,{children:(0,A.jsx)($.Action,{title:"Open Command Preferences",onAction:async()=>await(0,$.openCommandPreferences)(),shortcut:{modifiers:["cmd","shift"],key:","}})})}),r.map(a=>(0,A.jsx)($.List.Item,{title:a,actions:(0,A.jsxs)($.ActionPanel,{children:[(0,A.jsx)($.Action,{title:`Convert to ${a}`,icon:$.Icon.Switch,onAction:async()=>{let s=await $e();await ce({operation:()=>W(s,a),selectedImages:s,inProgressMessage:"Conversion in progress...",successMessage:"Converted",failureMessage:"Failed to convert"})}}),(0,A.jsx)($.Action.CreateQuicklink,{title:"Create Quicklink",quicklink:{name:`Convert to ${a}`,link:`raycast://extensions/HelloImSteven/sips/convert?context=${encodeURIComponent(JSON.stringify({convertTo:a}))}`}}),(0,A.jsx)(ue,{})]})},a))]})}
