import{_ as t,c as r,a3 as s,o as a}from"./chunks/framework.Br0sn5vz.js";const f=JSON.parse('{"title":"Life cycle","description":"","frontmatter":{},"headers":[],"relativePath":"http/life-cycle.md","filePath":"http/life-cycle.md"}'),i={name:"http/life-cycle.md"};function o(l,e,n,c,h,p){return a(),r("div",null,e[0]||(e[0]=[s('<h1 id="life-cycle" tabindex="-1">Life cycle <a class="header-anchor" href="#life-cycle" aria-label="Permalink to &quot;Life cycle&quot;">​</a></h1><p>Here is an overview of the journey of the request to the response.</p><ol><li>A request is made to the server</li><li>An initial empty response is passed through global middlewares (<a href="/mantis/http/middleware.html#before-route-matching">before route matching</a>)</li><li>One of your route matched the request</li><li>The response passes through route middlewares (before route rendering)</li><li>The response passes to your route callback (<a href="/mantis/http/response.html">route rendering</a>)</li><li>The response passes through route middlewares (after route rendering)</li><li>The response passes through global middlewares (after route matching)</li><li>The response is returned</li></ol>',3)]))}const u=t(i,[["render",o]]);export{f as __pageData,u as default};
