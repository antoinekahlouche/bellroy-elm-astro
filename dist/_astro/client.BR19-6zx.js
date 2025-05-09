function f(n){return(t,e,i,o)=>{if(!t||!(typeof t=="object"&&"__name"in t&&typeof t.__name=="string"&&"init"in t&&typeof t.init=="function"))return;const d=t,s=d.__name;try{const r=d.init({node:n,flags:e});c(s,r)}catch(r){l(n,s,r)}}}function c(n,t){typeof window.onElmInit=="function"?window.onElmInit(n,t):window.__elmInitQueue.push({elmModuleName:n,app:t})}function l(n,t,e){const i=document.createElement("pre");if(e instanceof Error){const{stack:o}=e;i.textContent=`Module "${t}" cannot be initialized.

${o}`}else i.textContent=`Module "${t}" cannot be initialized.

${e}`;Object.assign(i.style,{borderLeft:"1px solid red",paddingLeft:"24px"}),n.appendChild(i)}export{f as default};
