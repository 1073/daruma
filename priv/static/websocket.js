var WebSocketHandler=
    {
        websocket:null,
        init:function()
        {
            //check WebScocket support
            if(!("WebSocket" in window))
            {
                $('#status').append('<p><span style="color:red;">websockets aren not supported</span></p>');
            }
            else
            {
                $('#status').append('<p><span style="color:green;">websockets are supported</span></p>');
                WebSocketHandler.connect();
            }
        },
        connect:function()
        {
            wsHost=$("#server").val();
            websocket=new WebSocket(wsHost);
            websocket.onopen=function(evt){WebSocketHandler.onOpen(evt)};
            websocket.onclose=function(evt){WebSocketHandler.onClose(evt)};
            websocket.onmessage=function(evt){WebSocketHandler.onMessage(evt)};
            websocket.onerror=function(evt){WebSocketHandler.onError(evt)};
        },
        disconnect:function()
        {
            websocket.close();
        },
        onOpen:function(evt){},
        onClose:function(evt){},
        onMessage:function(evt)
        {
            var result = JSON.parse(evt.data);
            var time = evt.timeStamp;
            
            for(var i=0; i<result.nodes.length; i++)
            {
                var id=result.nodes[i];
                
                if($("span[data-node='"+id+"']").size()==0)
                {
                    var span=$("<span class='node'data-time='"+time+"'data-node='"+id+"'>").html(result.nodes[i]);
                    $("#status").append(span);
                }
                else
                {
                    $("span[data-node='"+id+"']").attr("data-time",time);
                }
            }
        $("span[data-time!='"+time+"']").remove();
        }
    };
