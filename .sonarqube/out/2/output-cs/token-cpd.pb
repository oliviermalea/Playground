⁄
iC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Messaging.Shared\Consumers\HealthCheckConsumer.cs
	namespace 	
ShowRoom
 
. 
	Messaging 
. 
Shared #
.# $
	Consumers$ -
;- .
public 
class 
HealthCheckConsumer  
:! "
	IConsumer# ,
<, -
IHealthCheckRequest- @
>@ A
{		 
private

 
readonly

 
ILogger

 
<

 
HealthCheckConsumer

 0
>

0 1
_logger

2 9
;

9 :
public 

HealthCheckConsumer 
( 
ILogger &
<& '
HealthCheckConsumer' :
>: ;
logger< B
)B C
{ 
_logger 
= 
logger 
; 
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -
IHealthCheckRequest- @
>@ A
contextB I
)I J
{ 
_logger 
. 
LogInformation 
( 
$" !
$str! E
{E F
contextF M
.M N
MessageN U
.U V
ServiceV ]
}] ^
$str^ b
{b c
contextc j
.j k
Messagek r
.r s
SentDates {
}{ |
$str	| á
{
á à
context
à è
.
è ê
Message
ê ó
.
ó ò
	IsHealthy
ò °
}
° ¢
"
¢ £
)
£ §
;
§ •
await 
context 
. 
RespondAsync "
<" #
IHealthCheckRequest# 6
>6 7
(7 8
HealthCheckBuilder8 J
.J K
BuildK P
(P Q
)Q R
)R S
.S T
ConfigureAwaitT b
(b c
falsec h
)h i
;i j
} 
} €
hC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Messaging.Shared\Contracts\HealthCheckBuilder.cs
	namespace 	
ShowRoom
 
. 
	Messaging 
. 
Shared #
.# $
	Contracts$ -
;- .
public 
static 
class 
HealthCheckBuilder &
{ 
public 

static 
dynamic 
Build 
(  
)  !
=>" $
new		 
{

 	
SentDate 
= 
DateTime 
.  
Now  #
,# $
Service 
= 
Assembly 
. 
GetEntryAssembly /
(/ 0
)0 1
.1 2
GetName2 9
(9 :
): ;
.; <
Name< @
,@ A
	IsHealthy 
= 
true 
} 	
;	 

} ¡
iC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Messaging.Shared\Contracts\IHealthCheckRequest.cs
	namespace 	
ShowRoom
 
. 
	Messaging 
. 
Shared #
.# $
	Contracts$ -
{ 
public 

	interface 
IHealthCheckRequest (
{ 
DateTime 
SentDate 
{ 
get 
;  
}! "
string		 
Service		 
{		 
get		 
;		 
}		 
bool 
	IsHealthy 
{ 
get 
; 
} 
} 
} ∂2
lC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Messaging.Shared\Extensions\MassTransitExtensions.cs
	namespace 	
ShowRoom
 
. 
	Messaging 
. 
Shared #
.# $

Extensions$ .
;. /
public		 
static		 
class		 !
MassTransitExtensions		 )
{

 
public 

static !
RabbitMQConfiguration '!
MessageBrokerSettings( =
{> ?
get@ C
;C D
setE H
;H I
}J K
public 

static 
IServiceCollection $"
AddMassTransitRabbitMq% ;
(; <
this< @
IServiceCollectionA S
servicesT \
,\ ] 
ConfigurationManager^ r
configuration	s Ä
,
Ä Å
Action
Ç à
<
à â
IServiceProvider
â ô
,
ô ö-
IRabbitMqBusFactoryConfigurator
õ ∫
>
∫ ª
callback
º ƒ
)
ƒ ≈
{ 
try 
{ 	!
MessageBrokerSettings !
=" #
configuration$ 1
.1 2

GetSection2 <
(< =
nameof= C
(C D!
RabbitMQConfigurationD Y
)Y Z
)Z [
.[ \
Get\ _
<_ `!
RabbitMQConfiguration` u
>u v
(v w
)w x
;x y
services 
. 
AddSingleton !
(! "
provider" *
=>+ -
Bus. 1
.1 2
Factory2 9
.9 :
CreateUsingRabbitMq: M
(M N
cfgN Q
=>R T
{ 
cfg 
. 
ConfigureRabbitMQ %
(% &
)& '
;' (
callback 
( 
provider !
,! "
cfg# &
)& '
;' (
} 
) 
) 
; 
services 
. 
AddSingleton !
<! "
IPublishEndpoint" 2
>2 3
(3 4
provider4 <
=>= ?
provider@ H
.H I
GetRequiredServiceI [
<[ \
IBusControl\ g
>g h
(h i
)i j
)j k
;k l
services 
. 
AddSingleton !
<! "!
ISendEndpointProvider" 7
>7 8
(8 9
provider9 A
=>B D
providerE M
.M N
GetRequiredServiceN `
<` a
IBusControla l
>l m
(m n
)n o
)o p
;p q
services 
. 
AddSingleton !
<! "
IBus" &
>& '
(' (
provider( 0
=>1 3
provider4 <
.< =
GetRequiredService= O
<O P
IBusControlP [
>[ \
(\ ]
)] ^
)^ _
;_ `
services 
. 
AddHostedService %
<% &(
MassTransitBusControlService& B
>B C
(C D
)D E
;E F
} 	
catch 
( 
	Exception 
e 
) 
{   	
Log!! 
.!! 
Error!! 
(!! 
$"!! 
$str!! K
"!!K L
)!!L M
;!!M N
Log"" 
."" 
Error"" 
("" 
$""" 
$str"" 1
{""1 2
e""2 3
.""3 4
Message""4 ;
}""; <
"""< =
)""= >
;""> ?
}## 	
return&& 
services&& 
;&& 
}'' 
public)) 

static)) 
void)) 
ConfigureEndpoint)) (
())( )
this))) -+
IRabbitMqBusFactoryConfigurator)). M
cfg))N Q
,))Q R
IServiceProvider))S c
provider))d l
,))l m
string))n t
endpointName	))u Å
,
))Å Ç
Action
))É â
<
))â ä2
$IRabbitMqReceiveEndpointConfigurator
))ä Æ
,
))Æ Ø
IServiceProvider
))∞ ¿
>
))¿ ¡
cb
))¬ ƒ
)
))ƒ ≈
{** 
cfg++ 
.++ 
ReceiveEndpoint++ 
(++ 
endpointName++ (
,++( )
cfgEndpoint,, 
=>,, 
{-- 
cb.. 
(.. 
cfgEndpoint.. !
,..! "
provider..# +
)..+ ,
;.., -
cfgEndpoint// 
.// 
UseMessageRetry// .
(//. /
cfgRetry/// 7
=>//8 :
{00 
cfgRetry11 
.11  
Interval11  (
(11( )
$num11) *
,11* +
TimeSpan11, 4
.114 5
FromSeconds115 @
(11@ A
$num11A B
)11B C
)11C D
;11D E
}22 
)22 
;22 
}33 
)33 
;33 
}44 
private66 
static66 
void66 
ConfigureRabbitMQ66 )
(66) *
this66* .+
IRabbitMqBusFactoryConfigurator66/ N
cfg66O R
)66R S
{77 
cfg88 
.88 
Host88 
(88 
new88 
Uri88 
(88 
	uriString88 "
:88" #
$"88$ &
$str88& 1
{881 2!
MessageBrokerSettings882 G
.88G H
Host88H L
}88L M
$str88M N
{88N O!
MessageBrokerSettings88O d
.88d e
VirtualHost88e p
}88p q
"88q r
)88r s
,88s t
h99 
=>99 
{:: 
h;; 
.;; 
Username;; 
(;; !
MessageBrokerSettings;; 0
.;;0 1
UserName;;1 9
);;9 :
;;;: ;
h<< 
.<< 
Password<< 
(<< !
MessageBrokerSettings<< 0
.<<0 1
Password<<1 9
)<<9 :
;<<: ;
h== 
.== 
	Heartbeat== 
(== 
$num== 
)== 
;==  
}>> 
)>> 
;>> 
}?? 
}@@ ¸
hC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Messaging.Shared\MassTransitBusControlService.cs
	namespace 	
ShowRoom
 
. 
	Messaging 
. 
Shared #
;# $
public

 
class

 (
MassTransitBusControlService

 )
:

* +
IHostedService

, :
{ 
private 
readonly 
ILogger 
< (
MassTransitBusControlService 9
>9 :
logger; A
;A B
private 
readonly 
IBusControl  

busControl! +
;+ ,
public 
(
MassTransitBusControlService '
(' (
ILogger 
< (
MassTransitBusControlService ,
>, -
logger. 4
,4 5
IBusControl 

busControl 
) 	
{ 
this 
. 
logger 
= 
logger 
; 
this 
. 

busControl 
= 

busControl $
;$ %
} 
public 

async 
Task 

StartAsync  
(  !
CancellationToken! 2
cancellationToken3 D
)D E
{ 
this 
. 
logger 
. 
LogInformation "
(" #
$str# 1
)1 2
;2 3#
CancellationTokenSource 
cts  #
=$ %
new& )#
CancellationTokenSource* A
(A B
newB E
TimeSpanF N
(N O
$numO P
,P Q
$numR S
,S T
$numU W
)W X
)X Y
;Y Z
CancellationToken 
token 
=  !
cts" %
.% &
Token& +
;+ ,
await 
this 
. 

busControl 
. 

StartAsync (
(( )
token) .
). /
./ 0
ConfigureAwait0 >
(> ?
false? D
)D E
;E F
} 
public   

async   
Task   
	StopAsync   
(    
CancellationToken    1
cancellationToken  2 C
)  C D
{!! 
this"" 
."" 
logger"" 
."" 
LogInformation"" "
(""" #
$str""# 1
)""1 2
;""2 3
await## 
this## 
.## 

busControl## 
.## 
	StopAsync## '
(##' (
cancellationToken##( 9
)##9 :
;##: ;
}$$ 
}%% ø
aC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Messaging.Shared\RabbitMQConfiguration.cs
	namespace 	
ShowRoom
 
. 
	Messaging 
. 
Shared #
;# $
public 
class !
RabbitMQConfiguration "
{ 
public 

string 
Host 
{ 
get 
; 
set !
;! "
}# $
public 

int 
Port 
{ 
get 
; 
set 
; 
}  !
public		 

string		 
UserName		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
VirtualHost 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int  
MaxConnectionRetries #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$num4 8
;8 9
public 

double )
ConnectionAttempBackoffFactor /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
=> ?
$num@ C
;C D
public 

int &
ConnectionAttempMaxBackoff )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
=8 9
$num: ?
;? @
public 

int -
!PublishConnectionTimeoutInSeconds 0
{1 2
get3 6
;6 7
set8 ;
;; <
}= >
=? @
$numA C
;C D
} 