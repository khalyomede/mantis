import{_ as i,c as a,a1 as n,o as l}from"./chunks/framework.CNY3Wz3S.js";const E=JSON.parse('{"title":"Logging","description":"","frontmatter":{},"headers":[],"relativePath":"logging.md","filePath":"logging.md"}'),t={name:"logging.md"};function e(p,s,h,k,g,d){return l(),a("div",null,s[0]||(s[0]=[n(`<h1 id="logging" tabindex="-1">Logging <a class="header-anchor" href="#logging" aria-label="Permalink to &quot;Logging&quot;">​</a></h1><h2 id="file-logging" tabindex="-1">File logging <a class="header-anchor" href="#file-logging" aria-label="Permalink to &quot;File logging&quot;">​</a></h2><p>You can log on a given file.</p><div class="vp-code-group vp-adaptive-theme"><div class="tabs"><input type="radio" name="group-N2crA" id="tab-LSHRay1" checked><label data-title="main.v" for="tab-LSHRay1">main.v</label><input type="radio" name="group-N2crA" id="tab-vKZiS6L"><label data-title="logs/mantis.log" for="tab-vKZiS6L">logs/mantis.log</label></div><div class="blocks"><div class="language-v vp-adaptive-theme active"><button title="Copy Code" class="copy"></button><span class="lang">v</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">module</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> main</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">import</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> khalyomede.mantis.logging</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> { Log }</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">import</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> khalyomede.mantis.logging.channel</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> { File }</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">fn</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> main</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">() {</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">  mut</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> log </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Log{</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    channel: File{</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">      path: </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;logs/mantis.log&quot;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    }</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">  }</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">  log.</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">debug</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;Email sent.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">}</span></span></code></pre></div><div class="language-log vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">log</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">[</span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;">2024-12-26T17:31:05.147793327Z</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">] </span><span style="--shiki-light:#E36209;--shiki-dark:#FFAB70;">[DBUG]</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Email sent.</span></span></code></pre></div></div></div><p>You can also manually set the severity:</p><div class="vp-code-group vp-adaptive-theme"><div class="tabs"><input type="radio" name="group-Cbwrh" id="tab-e4OGf0Z" checked><label data-title="main.v" for="tab-e4OGf0Z">main.v</label><input type="radio" name="group-Cbwrh" id="tab-EXZ-YZR"><label data-title="logs/mantis.log" for="tab-EXZ-YZR">logs/mantis.log</label></div><div class="blocks"><div class="language-v vp-adaptive-theme active"><button title="Copy Code" class="copy"></button><span class="lang">v</span><pre class="shiki shiki-themes github-light github-dark has-focused-lines vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">module</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> main</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">import</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> khalyomede.mantis.logging</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> { Log }</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">import</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> khalyomede.mantis.logging.channel</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> { File }</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">fn</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;"> main</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">() {</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">  mut</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> log </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Log{</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    channel: File{</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">      path: </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;logs/mantis.log&quot;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    }</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">  }</span></span>
<span class="line"></span>
<span class="line has-focus"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">  log.</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">log</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(.error, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;Database connection lost.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">}</span></span></code></pre></div><div class="language-log vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">log</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">[</span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;">2024-12-26T17:41:19.933122161Z</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">] [ERRO] Database connection lost.</span></span></code></pre></div></div></div>`,6)]))}const r=i(t,[["render",e]]);export{E as __pageData,r as default};
