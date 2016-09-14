<g:if test="${posts.empty}">
    <g:javascript>
        alert("There are no more previous posts!");
    </g:javascript>
</g:if>
<g:else>
    <g:each var="p" in="${posts}">
        <g:javascript>
            var $div = createPost('${p.question.id}','${p.question.type.shortName}', '${p.postText}', '${p.id}', ${p.isLatest}, false, false, true);
            $div.animate({
              backgroundColor: "#4897c5",
              color: "#fffff"
            }, 700);
            $div.animate({
              backgroundColor: "#d9edf7",
              color:"#333333"
            }, 700);
        </g:javascript>
    </g:each>
</g:else>