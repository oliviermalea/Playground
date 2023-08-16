÷
lC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Features\Customer\CustomerFactory.cs
[ 
assembly 	
:	 

System 
. 
Runtime 
. 
CompilerServices *
.* +
InternalsVisibleTo+ =
(= >
$str> N
)N O
]O P
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Features# +
.+ ,
Customer, 4
{ 
internal 
static 
class 
CustomerFactory )
{ 
internal		 
static		 
async		 
Task		 "
<		" #
GetCustomerResponse		# 6
>		6 7
GenerateCustomer		8 H
(		H I
Guid		I M
id		N P
,		P Q
bool		R V
?		V W
isActive		X `
,		` a
CancellationToken		b s
cancellation			t Ä
=
		Å Ç
default
		É ä
)
		ä ã
{

 	
return 
await 
Task 
. 
Run !
(! "
(" #
)# $
=>% '
{ 
var 
item 
= 
new 
Faker $
<$ %
GetCustomerResponse% 8
>8 9
(9 :
): ;
. 
CustomInstantiator '
(' (
f( )
=>* ,
new- 0
GetCustomerResponse1 D
(D E
)E F
)F G
. 
RuleFor 
( 
u 
=> !
u" #
.# $

CustomerId$ .
,. /
id0 2
)2 3
. 
RuleFor 
( 
u 
=> !
u" #
.# $
IsActive$ ,
,, -
isActive. 6
??7 9
true: >
)> ?
. 
RuleFor 
( 
u 
=> !
u" #
.# $
	FirstName$ -
,- .
(/ 0
f0 1
,1 2
u3 4
)4 5
=>6 8
f9 :
.: ;
Name; ?
.? @
	FirstName@ I
(I J
)J K
)K L
. 
RuleFor 
( 
u 
=> !
u" #
.# $
LastName$ ,
,, -
(. /
f/ 0
,0 1
u2 3
)3 4
=>5 7
f8 9
.9 :
Name: >
.> ?
LastName? G
(G H
)H I
)I J
. 
RuleFor 
( 
u 
=> !
u" #
.# $
Email$ )
,) *
(+ ,
f, -
,- .
u/ 0
)0 1
=>2 4
f5 6
.6 7
Internet7 ?
.? @
Email@ E
(E F
uF G
.G H
	FirstNameH Q
,Q R
uS T
.T U
LastNameU ]
)] ^
)^ _
;_ `
return 
item 
. 
Generate $
($ %
)% &
;& '
} 
, 
cancellation 
) 
; 
} 	
} 
} …
lC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Features\Customer\CustomersModule.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Features# +
.+ ,
Customer, 4
;4 5
public 
class 
CustomersModule 
: 
CarterModule +
{ 
const 	
string
 
	baseRoute 
= 
$str -
;- .
public 

CustomersModule 
( 
) 
: 
base #
(# $
	baseRoute$ -
)- .
{ 
this 
. 
IncludeInOpenApi 
( 
) 
;  
this 
. 
Before 
= 
context 
=>  
{ 	
var 
logger 
= 
context  
.  !
HttpContext! ,
., -
RequestServices- <
.< =
GetRequiredService= O
<O P
ILoggerP W
<W X
CustomersModuleX g
>g h
>h i
(i j
)j k
;k l
logger 
. 
LogDebug 
( 
$str $
)$ %
;% &
return 
null 
; 
} 	
;	 

this 
. 
After 
= 
context 
=> 
{ 	
var 
logger 
= 
context  
.  !
HttpContext! ,
., -
RequestServices- <
.< =
GetRequiredService= O
<O P
ILoggerP W
<W X
CustomersModuleX g
>g h
>h i
(i j
)j k
;k l
logger 
. 
LogDebug 
( 
$str #
)# $
;$ %
} 	
;	 

} 
public!! 

override!! 
void!! 
	AddRoutes!! "
(!!" #!
IEndpointRouteBuilder!!# 8
app!!9 <
)!!< =
{"" 
app## 
.## 
MapGet## 
(## 
$str## 
,## 
async## 
(## 
[##  
AsParameters##  ,
]##, -
GetCustomerRequest##. @
request##A H
,##H I
ILogger##J Q
<##Q R
CustomersModule##R a
>##a b
logger##c i
,##i j
	IMediator##k t
mediator##u }
)##} ~
=>	## Å
{$$ 	
var%% 
result%% 
=%% 
await%% 
mediator%% '
.%%' (
Send%%( ,
(%%, -
request%%- 4
)%%4 5
;%%5 6
logger'' 
.'' 
LogInformation'' !
(''! "
$str''" ;
,''; <
result''= C
.''C D
Value''D I
)''I J
;''J K
if)) 
()) 
result)) 
.)) 
Value)) 
is)) 
null))  $
)))$ %
return** 
Results** 
.** 
Empty** $
;**$ %
return,, 
Results,, 
.,, 
Ok,, 
(,, 
result,, $
.,,$ %
Value,,% *
),,* +
;,,+ ,
}-- 	
)--	 

;--
 
}.. 
}// ˚#
ÄC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Features\Customer\GetCustomer\GetCustomerQueryHandler.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Features# +
.+ ,
Customer, 4
.4 5
GetCustomer5 @
;@ A
public		 
class		 #
GetCustomerQueryHandler		 $
:		% &
IRequestHandler		' 6
<		6 7
GetCustomerRequest		7 I
,		I J
Result		K Q
<		Q R
GetCustomerResponse		R e
>		e f
>		f g
{

 
	protected 
readonly 
ILogger 
< #
GetCustomerQueryHandler 6
>6 7
_logger8 ?
;? @
private 
readonly 
IRequestClient #
<# $!
CustomerOrdersRequest$ 9
>9 :!
_customerOrdersClient; P
;P Q
public 
#
GetCustomerQueryHandler "
(" #
ILogger 
< #
GetCustomerQueryHandler '
>' (
logger) /
,/ 0
IRequestClient 
< !
CustomerOrdersRequest ,
>, - 
customerOrdersClient. B
) 	
{ 
_logger 
= 
logger 
; 
this 
. !
_customerOrdersClient "
=# $ 
customerOrdersClient% 9
;9 :
} 
public 

async 
Task 
< 
Result 
< 
GetCustomerResponse 0
>0 1
>1 2
Handle3 9
(9 :
GetCustomerRequest: L
requestM T
,T U
CancellationTokenV g
cancellationTokenh y
)y z
{ 
var 
customer 
= 
await 
CustomerFactory ,
., -
GenerateCustomer- =
(= >
request> E
.E F

CustomerIdF P
,P Q
requestR Y
.Y Z
IsActiveZ b
,b c
cancellationTokend u
)u v
.v w
ConfigureAwait	w Ö
(
Ö Ü
false
Ü ã
)
ã å
;
å ç
var 
customerOrders 
= 
await "!
_customerOrdersClient# 8
. 
GetResponse 
< "
CustomerOrdersResponse /
,/ 0*
CustomerOrdersNotFoundResponse1 O
>O P
(P Q
newQ T!
CustomerOrdersRequestU j
(j k
Guidk o
.o p
NewGuidp w
(w x
)x y
,y z
customer	{ É
.
É Ñ

CustomerId
Ñ é
)
é è
)
è ê
;
ê ë
if 

( 
customerOrders 
. 
Is 
( 
out !
Response" *
<* +"
CustomerOrdersResponse+ A
>A B
foundOrdersC N
)N O
)O P
{ 	
_logger   
.   
LogInformation   "
(  " #
$str  # s
,  s t
customer  u }
.  } ~

CustomerId	  ~ à
,
  à â
foundOrders
  ä ï
.
  ï ñ
Message
  ñ ù
.
  ù û
Orders
  û §
.
  § •
Length
  • ´
)
  ´ ¨
;
  ¨ ≠
customer!! 
.!! 
Orders!! 
.!! 
AddRange!! $
(!!$ %
foundOrders!!% 0
.!!0 1
Message!!1 8
.!!8 9
Orders!!9 ?
)!!? @
;!!@ A
}"" 	
else## 
if## 
(## 
customerOrders## 
.##  
Is##  "
(##" #
out### &
Response##' /
<##/ 0*
CustomerOrdersNotFoundResponse##0 N
>##N O
notFoundOrders##P ^
)##^ _
)##_ `
{$$ 	
_logger%% 
.%% 
LogInformation%% "
(%%" #
$str%%# ]
,%%] ^
customer%%_ g
.%%g h

CustomerId%%h r
)%%r s
;%%s t
}&& 	
return(( 
Result(( 
.(( 
Success(( 
((( 
customer(( &
)((& '
;((' (
})) 
}** ü
{C:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Features\Customer\GetCustomer\GetCustomerRequest.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Features# +
.+ ,
Customer, 4
.4 5
GetCustomer5 @
;@ A
public 
record 
struct 
GetCustomerRequest '
(' (
Guid( ,

CustomerId- 7
,7 8
bool9 =
?= >
IsActive? G
=H I
trueJ N
)N O
:P Q
IRequestR Z
<Z [
Result[ a
<a b
GetCustomerResponseb u
>u v
>v w
;w x≥
ÑC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Features\Customer\GetCustomer\GetCustomerRequestValidator.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Features# +
.+ ,
Customer, 4
.4 5
GetCustomer5 @
{ 
public 

class '
GetCustomerRequestValidator ,
:- .
AbstractValidator/ @
<@ A
GetCustomerRequestA S
>S T
{ 
public '
GetCustomerRequestValidator *
(* +
)+ ,
{ 	
RuleFor		 
(		 
x		 
=>		 
x		 
.		 

CustomerId		 %
)		% &
.		& '
NotEmpty		' /
(		/ 0
)		0 1
;		1 2
}

 	
} 
} Ò
|C:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Features\Customer\GetCustomer\GetCustomerResponse.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Features# +
.+ ,
Customer, 4
.4 5
GetCustomer5 @
;@ A
public 
record 
GetCustomerResponse !
{ 
public 

Guid 

CustomerId 
{ 
get !
;! "
set# &
;& '
}( )
public 

bool 
IsActive 
{ 
get 
; 
set  #
;# $
}% &
public		 

string		 
LastName		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
public

 

string

 
	FirstName

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
public 

List 
< 
Order 
> 
Orders 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
new. 1
(1 2
)2 3
;3 4
} ©
hC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Infrastructure\ActivityHelper.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Infrastructure# 1
;1 2
public 
static 
class 
ActivityHelper #
{ 
public 

readonly 
static 
ActivitySource )
Source* 0
=1 2
new3 6
ActivitySource7 E
(E F
InstrumentationF U
.U V
ActivitySourceNameV h
)h i
;i j
}		 †
tC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Infrastructure\Behaviour\LoggingBehaviour.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Infrastructure# 1
.1 2
	Behaviour2 ;
;; <
public 
class 
LoggingBehaviour 
< 
TRequest &
,& '
	TResponse( 1
>1 2
:3 4
IPipelineBehavior5 F
<F G
TRequestG O
,O P
	TResponseQ Z
>Z [
{ 
private 
readonly 
ILogger 
< 
LoggingBehaviour -
<- .
TRequest. 6
,6 7
	TResponse8 A
>A B
>B C
_loggerD K
;K L
public

 

LoggingBehaviour

 
(

 
ILogger

 #
<

# $
LoggingBehaviour

$ 4
<

4 5
TRequest

5 =
,

= >
	TResponse

? H
>

H I
>

I J
logger

K Q
)

Q R
{ 
_logger 
= 
logger 
; 
} 
public 

async 
Task 
< 
	TResponse 
>  
Handle! '
(' (
TRequest( 0
request1 8
,8 9"
RequestHandlerDelegate: P
<P Q
	TResponseQ Z
>Z [
next\ `
,` a
CancellationTokenb s
cancellationToken	t Ö
)
Ö Ü
{ 
_logger 
. 
LogInformation 
( 
$str 7
,7 8
typeof9 ?
(? @
TRequest@ H
)H I
.I J
NameJ N
)N O
;O P
Type 
myType 
= 
request 
. 
GetType %
(% &
)& '
;' (
IList 
< 
PropertyInfo 
> 
props !
=" #
new$ '
List( ,
<, -
PropertyInfo- 9
>9 :
(: ;
myType; A
.A B
GetPropertiesB O
(O P
)P Q
)Q R
;R S
foreach 
( 
PropertyInfo 
prop "
in# %
props& +
)+ ,
{ 	
object 
	propValue 
= 
prop #
.# $
GetValue$ ,
(, -
request- 4
,4 5
null6 :
): ;
;; <
_logger 
. 
LogInformation "
(" #
$str# :
,: ;
prop< @
.@ A
NameA E
,E F
	propValueG P
)P Q
;Q R
} 	
var 
response 
= 
await 
next !
(! "
)" #
;# $
_logger 
. 
LogInformation 
( 
$str 7
,7 8
typeof9 ?
(? @
	TResponse@ I
)I J
.J K
NameK O
)O P
;P Q
return 
response 
; 
} 
}   ê!
zC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Infrastructure\Behaviour\ObservabilityBehaviour.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Infrastructure# 1
.1 2
	Behaviour2 ;
;; <
public 
class "
ObservabilityBehaviour #
<# $
TRequest$ ,
,, -
	TResponse. 7
>7 8
:9 :
IPipelineBehavior; L
<L M
TRequestM U
,U V
	TResponseW `
>` a
{		 
private

 
readonly

 

OtelMetric

 
_metric

  '
;

' (
public 
"
ObservabilityBehaviour !
(! "

OtelMetric" ,
metric- 3
)3 4
{ 
_metric 
= 
metric 
; 
} 
public 

async 
Task 
< 
	TResponse 
>  
Handle! '
(' (
TRequest( 0
request1 8
,8 9"
RequestHandlerDelegate: P
<P Q
	TResponseQ Z
>Z [
next\ `
,` a
CancellationTokenb s
cancellationToken	t Ö
)
Ö Ü
{ 
var 
activityQuery 
= 
typeof "
(" #
TRequest# +
)+ ,
., -
Name- 1
;1 2
_metric 
. $
IncreaseCustomersQueried (
(( )
)) *
;* +
var 
	stopwatch 
= 
	Stopwatch !
.! "
StartNew" *
(* +
)+ ,
;, -
using 
( 
Activity 
activity  
=! "
ActivityHelper# 1
.1 2
Source2 8
.8 9
StartActivity9 F
(F G
activityQueryG T
,T U
ActivityKindV b
.b c
Serverc i
)i j
)j k
{ 	
activity 
? 
. 
AddTag 
( 
$str $
,$ %
typeof& ,
(, -
TRequest- 5
)5 6
.6 7
Name7 ;
); <
;< =
activity 
? 
. 

AddBaggage  
(  !
$str! *
,* +
typeof, 2
(2 3
TRequest3 ;
); <
.< =
Name= A
)A B
;B C
Type 
myType 
= 
request !
.! "
GetType" )
() *
)* +
;+ ,
IList 
< 
PropertyInfo 
> 
props  %
=& '
new( +
List, 0
<0 1
PropertyInfo1 =
>= >
(> ?
myType? E
.E F
GetPropertiesF S
(S T
)T U
)U V
;V W
foreach   
(   
PropertyInfo   !
prop  " &
in  ' )
props  * /
)  / 0
{!! 
object"" 
	propValue""  
=""! "
prop""# '
.""' (
GetValue""( 0
(""0 1
request""1 8
,""8 9
null"": >
)""> ?
;""? @
activity## 
?## 
.## 
AddTag##  
(##  !
prop##! %
.##% &
Name##& *
,##* +
	propValue##, 5
)##5 6
;##6 7
}$$ 
}%% 	
var&& 
response&& 
=&& 
await&& 
next&& !
(&&! "
)&&" #
;&&# $
_metric(( 
.(( .
"RecordCustomerItemsRequestDuration(( 2
(((2 3
	stopwatch((3 <
.((< =
ElapsedMilliseconds((= P
)((P Q
;((Q R
return** 
response** 
;** 
}++ 
},, ˇ
wC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Infrastructure\Behaviour\ValidationBehaviour.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Infrastructure# 1
.1 2
	Behaviour2 ;
;; <
public 
class 
ValidationBehaviour  
<  !
TRequest! )
,) *
	TResponse+ 4
>4 5
:6 7
IPipelineBehavior8 I
<I J
TRequestJ R
,R S
	TResponseT ]
>] ^
where_ d
TRequeste m
:n o
IRequestp x
<x y
	TResponse	y Ç
>
Ç É
{ 
private 
readonly 
IEnumerable  
<  !

IValidator! +
<+ ,
TRequest, 4
>4 5
>5 6
_validators7 B
;B C
public

 

ValidationBehaviour

 
(

 
IEnumerable

 *
<

* +

IValidator

+ 5
<

5 6
TRequest

6 >
>

> ?
>

? @

validators

A K
)

K L
{ 
_validators 
= 

validators  
;  !
} 
public 

async 
Task 
< 
	TResponse 
>  
Handle! '
(' (
TRequest( 0
request1 8
,8 9"
RequestHandlerDelegate: P
<P Q
	TResponseQ Z
>Z [
next\ `
,` a
CancellationTokenb s
cancellationToken	t Ö
)
Ö Ü
{ 
if 

( 
_validators 
. 
Any 
( 
) 
) 
{ 	
var 
context 
= 
new 
ValidationContext /
</ 0
TRequest0 8
>8 9
(9 :
request: A
)A B
;B C
var 
validationResults !
=" #
await$ )
Task* .
.. /
WhenAll/ 6
(6 7
_validators7 B
.B C
SelectC I
(I J
vJ K
=>L N
vO P
.P Q
ValidateAsyncQ ^
(^ _
context_ f
,f g
cancellationTokenh y
)y z
)z {
){ |
;| }
var 
failures 
= 
validationResults ,
., -

SelectMany- 7
(7 8
r8 9
=>: <
r= >
.> ?
Errors? E
)E F
.F G
WhereG L
(L M
fM N
=>O Q
fR S
!=T V
nullW [
)[ \
.\ ]
ToList] c
(c d
)d e
;e f
if 
( 
failures 
. 
Count 
!= !
$num" #
)# $
throw 
new 
ValidationException -
(- .
failures. 6
)6 7
;7 8
} 	
return 
await 
next 
( 
) 
; 
} 
} ˝
wC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Infrastructure\Observability\Instrumentation.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Infrastructure# 1
.1 2
Observability2 ?
;? @
public 
class 
Instrumentation 
: 
IDisposable *
{ 
internal 
const 
string 
ActivitySourceName ,
=- .
$str/ I
;I J
internal 
const 
string 
	MeterName #
=$ %
$str& @
;@ A
private 
readonly 
Meter 
meter  
;  !
public 

Instrumentation 
( 
) 
{ 
string 
? 
version 
= 
typeof  
(  !
Instrumentation! 0
)0 1
.1 2
Assembly2 :
.: ;
GetName; B
(B C
)C D
.D E
VersionE L
?L M
.M N
ToStringN V
(V W
)W X
;X Y
this 
. 
ActivitySource 
= 
new !
ActivitySource" 0
(0 1
ActivitySourceName1 C
,C D
versionE L
)L M
;M N
this 
. 
meter 
= 
new 
Meter 
( 
	MeterName (
,( )
version* 1
)1 2
;2 3
} 
public 

ActivitySource 
ActivitySource (
{) *
get+ .
;. /
}0 1
public 

void 
Dispose 
( 
) 
{ 
this 
. 
ActivitySource 
. 
Dispose #
(# $
)$ %
;% &
this 
. 
meter 
. 
Dispose 
( 
) 
; 
GC 

.
 
SuppressFinalize 
( 
this  
)  !
;! "
} 
}   ô
rC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Infrastructure\Observability\OtelMetric.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Infrastructure# 1
.1 2
Observability2 ?
;? @
public 
class 

OtelMetric 
{ 
private 
Counter 
< 
int 
>  
CustomerQueriedCount -
{. /
get0 3
;3 4
}5 6
private		 
	Histogram		 
<		 
long		 
>		 (
CustomerItemsRequestDuration		 8
{		9 :
get		; >
;		> ?
}		@ A
public 


OtelMetric 
( 
) 
{ 
var 
meter 
= 
new 
Meter 
( 
Instrumentation -
.- .
	MeterName. 7
)7 8
;8 9 
CustomerQueriedCount 
= 
meter $
.$ %
CreateCounter% 2
<2 3
int3 6
>6 7
(7 8
name8 <
:< =
$str= P
,P Q
unitR V
:V W
$strW a
)a b
;b c(
CustomerItemsRequestDuration $
=% &
meter' ,
., -
CreateHistogram- <
<< =
long= A
>A B
(B C
nameC G
:G H
$strH i
,i j
unitk o
:o p
$strq u
)u v
;v w
} 
public 

void $
IncreaseCustomersQueried (
(( )
)) *
=>+ - 
CustomerQueriedCount. B
.B C
AddC F
(F G
$numG H
)H I
;I J
public 

void .
"RecordCustomerItemsRequestDuration 2
(2 3
long3 7
duration8 @
)@ A
=>B D(
CustomerItemsRequestDurationE a
.a b
Recordb h
(h i
durationi q
,q r
tag1 
: 
KeyValuePair 
. 
Create !
<! "
string" (
,( )
object* 0
?0 1
>1 2
(2 3
$str3 <
,< =
nameof> D
(D E!
CustomerOrdersRequestE Z
)Z [
)[ \
,\ ]
tag2 
: 
KeyValuePair 
. 
Create !
<! "
string" (
,( )
object* 0
?0 1
>1 2
(2 3
$str3 B
,B C
durationD L
)L M
)M N
;N O
} è
ÖC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Infrastructure\ServicesSetup\MassTransitRabbitMqExtensions.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Infrastructure# 1
.1 2
ServicesSetup2 ?
{ 
public 

static 
class )
MassTransitRabbitMqExtensions 5
{ 
public 
static 
void 
AddMTRabbitMqBroker .
(. /
this/ 3
IServiceCollection4 F
servicesG O
,O P 
ConfigurationManagerQ e
configurationf s
)s t
{ 	
services 
. 
AddMassTransit #
(# $
m$ %
=>& (
{ 
m 
. -
!SetKebabCaseEndpointNameFormatter 3
(3 4
)4 5
;5 6
m 
. 
AddRequestClient "
<" #
IHealthCheckRequest# 6
>6 7
(7 8
)8 9
;9 :
m 
. 
AddRequestClient "
<" #!
CustomerOrdersRequest# 8
>8 9
(9 :
): ;
;; <
m 
. 
AddConsumer 
< 
HealthCheckConsumer 1
>1 2
(2 3
)3 4
;4 5
} 
) 
; 
services 
. "
AddMassTransitRabbitMq +
(+ ,
configuration, 9
,9 :
(; <
provider< D
,D E
cfgF I
)I J
=>K M
{ 
cfg 
. 
ConfigureEndpoint %
(% &
provider& .
,. /
nameof0 6
(6 7
IHealthCheckRequest7 J
)J K
,K L
( 
cfgEndpoint  
,  !
provider" *
)* +
=>, .
cfgEndpoint/ :
.: ;
Consumer; C
<C D
HealthCheckConsumerD W
>W X
(X Y
providerY a
)a b
)b c
;c d
cfg 
. 
Send 
< !
CustomerOrdersRequest .
>. /
(/ 0
x0 1
=>2 4
{ 
x 
. 
UseCorrelationId &
(& '
context' .
=>/ 1
context2 9
.9 :
CorrelationId: G
)G H
;H I
} 
) 
; 
}   
)   
;   
}!! 	
}"" 
}## ˇ
fC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Persistance\CustomerContext.cs
	namespace 	
ShowRoom
 
. 
Customer 
. 
WebApi "
." #
Persistance# .
{ 
public 

class 
CustomerContext  
{ 
} 
} ”s
RC:\Users\OlivierMal√©a\Documents\code\showroom\ShowRoom.Customer.WebAPi\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
var 
env 
= 	
builder
 
. 
Environment 
; 
var 
serviceName 
= 
env 
. 
ApplicationName %
;% &
Action'' 
<'' 
ResourceBuilder'' 
>'' 
configureResource'' )
=''* +
r'', -
=>''. 0
r''1 2
.''2 3

AddService''3 =
(''= >
serviceName(( 
:(( 
serviceName(( 
,(( 
serviceVersion)) 
:)) 
typeof)) 
()) 
Program)) "
)))" #
.))# $
Assembly))$ ,
.)), -
GetName))- 4
())4 5
)))5 6
.))6 7
Version))7 >
?))> ?
.))? @
ToString))@ H
())H I
)))I J
??))K M
$str))N W
,))W X
serviceInstanceId** 
:** 
Environment** "
.**" #
MachineName**# .
)**. /
;**/ 0
builder,, 
.,, 
Services,, 
.-- 

AddOptions-- 
<-- !
RabbitMQConfiguration-- %
>--% &
(--& '
)--' (
... 
ValidateOnStart.. 
(.. 
).. 
;.. 
builder00 
.00 
Services00 
.00  
AddFeatureManagement00 %
(00% &
)00& '
;00' (
builder88 
.88 
Services88 
.88 
AddSingleton88 
<88 
Instrumentation88 -
>88- .
(88. /
)88/ 0
;880 1
builder99 
.99 
Services99 
.99 
AddSingleton99 
<99 

OtelMetric99 (
>99( )
(99) *
)99* +
;99+ ,
builder;; 
.;; 
Services;; 
.;; 
AddOpenTelemetry;; !
(;;! "
);;" #
.<< 
ConfigureResource<< 
(<< 
configureResource<< (
)<<( )
.== 
WithTracing== 
(== 
traceBuilder== 
=>==  
{>> 
traceBuilder@@ 
.AA 
	AddSourceAA 
(AA 
InstrumentationAA &
.AA& '
ActivitySourceNameAA' 9
)AA9 :
.BB 
	AddSourceBB 
(BB 
DiagnosticHeadersBB (
.BB( )
DefaultListenerNameBB) <
)BB< =
.CC 
SetResourceBuilderCC 
(CC  
ResourceBuilderCC  /
.CC/ 0
CreateDefaultCC0 =
(CC= >
)CC> ?
.CC? @

AddServiceCC@ J
(CCJ K
serviceNameCCK V
)CCV W
)CCW X
.DD 

SetSamplerDD 
(DD 
newDD 
AlwaysOnSamplerDD +
(DD+ ,
)DD, -
)DD- .
.EE (
AddHttpClientInstrumentationEE )
(EE) *
)EE* +
.FF (
AddAspNetCoreInstrumentationFF )
(FF) *
)FF* +
.HH 
AddConsoleExporterHH 
(HH  
)HH  !
;HH! "
traceBuilderJJ 
.JJ 
AddOtlpExporterJJ $
(JJ$ %
otlpOptionsJJ% 0
=>JJ1 3
{KK 	
otlpOptionsMM 
.MM 
EndpointMM  
=MM! "
newMM# &
UriMM' *
(MM* +
builderMM+ 2
.MM2 3
ConfigurationMM3 @
.MM@ A
GetValueMMA I
<MMI J
stringMMJ P
>MMP Q
(MMQ R
$strMMR a
)MMa b
)MMb c
;MMc d
}NN 	
)NN	 

;NN
 
}OO 
)OO 
.PP 
WithMetricsPP 
(PP 
metricBuilderPP 
=>PP !
{QQ 
metricBuilderRR 
.SS 
AddMeterSS 
(SS 
InstrumentationSS %
.SS% &
	MeterNameSS& /
)SS/ 0
.TT 
AddMeterTT 
(TT "
InstrumentationOptionsTT ,
.TT, -
	MeterNameTT- 6
)TT6 7
.UU (
AddHttpClientInstrumentationUU )
(UU) *
)UU* +
.VV (
AddAspNetCoreInstrumentationVV )
(VV) *
)VV* +
.WW %
AddRuntimeInstrumentationWW &
(WW& '
)WW' (
.XX %
AddProcessInstrumentationXX &
(XX& '
)XX' (
;XX( )
metricBuilderZZ 
.ZZ 
AddOtlpExporterZZ %
(ZZ% &
otlpOptionsZZ& 1
=>ZZ2 4
{[[ 	
otlpOptions]] 
.]] 
Endpoint]]  
=]]! "
new]]# &
Uri]]' *
(]]* +
builder]]+ 2
.]]2 3
Configuration]]3 @
.]]@ A
GetValue]]A I
<]]I J
string]]J P
>]]P Q
(]]Q R
$str]]R a
)]]a b
)]]b c
;]]c d
}^^ 	
)^^	 

;^^
 
}__ 
)__ 
;__ 
Logbb 
.bb 
Loggerbb 

=bb "
CreateSerilogAppLoggerbb #
(bb# $
)bb$ %
;bb% &
Logcc 
.cc 
Informationcc 
(cc 
$strcc 
)cc 
;cc 
Logdd 
.dd 
Informationdd 
(dd 
$"dd 
$strdd 
{dd 
serviceNamedd (
}dd( )
$strdd) -
"dd- .
)dd. /
;dd/ 0
builderee 
.ee 
Hostee 
.ee 

UseSerilogee 
(ee 
)ee 
;ee 
varpp 
configurationpp 
=pp 
builderpp 
.pp 
Configurationpp )
;pp) *
configurationqq 
.qq 
SetBasePathqq 
(qq 
envqq 
.qq 
ContentRootPathqq -
)qq- .
;qq. /
configurationrr 
.rr 
AddJsonFilerr 
(rr 
$strrr ,
,rr, -
falserr. 3
,rr3 4
truerr5 9
)rr9 :
;rr: ;
configurationvv 
.vv #
AddEnvironmentVariablesvv %
(vv% &
)vv& '
;vv' (
builderzz 
.zz 
Serviceszz 
.zz 
AddHealthCheckszz  
(zz  !
)zz! "
;zz" #
builder{{ 
.{{ 
Services{{ 
.{{ #
AddEndpointsApiExplorer{{ (
({{( )
){{) *
;{{* +
builder|| 
.|| 
Services|| 
.|| 

AddMediatR|| 
(|| 
cfg|| 
=>||  "
cfg||# &
.||& '(
RegisterServicesFromAssembly||' C
(||C D
typeof||D J
(||J K
Program||K R
)||R S
.||S T
Assembly||T \
)||\ ]
)||] ^
.}} 
	AddScoped}} 
(}} 
typeof}} 
(}} 
IPipelineBehavior}} '
<}}' (
,}}( )
>}}) *
)}}* +
,}}+ ,
typeof}}- 3
(}}3 4"
ObservabilityBehaviour}}4 J
<}}J K
,}}K L
>}}L M
)}}M N
)}}N O
.~~ 
	AddScoped~~ 
(~~ 
typeof~~ 
(~~ 
IPipelineBehavior~~ '
<~~' (
,~~( )
>~~) *
)~~* +
,~~+ ,
typeof~~- 3
(~~3 4
LoggingBehaviour~~4 D
<~~D E
,~~E F
>~~F G
)~~G H
)~~H I
. 
	AddScoped 
( 
typeof 
( 
IPipelineBehavior '
<' (
,( )
>) *
)* +
,+ ,
typeof- 3
(3 4
ValidationBehaviour4 G
<G H
,H I
>I J
)J K
)K L
;L M
builderÄÄ 
.
ÄÄ 
Services
ÄÄ 
.
ÄÄ '
AddValidatorsFromAssembly
ÄÄ *
(
ÄÄ* +
typeof
ÄÄ+ 1
(
ÄÄ1 2
Program
ÄÄ2 9
)
ÄÄ9 :
.
ÄÄ: ;
Assembly
ÄÄ; C
)
ÄÄC D
;
ÄÄD E
builderÅÅ 
.
ÅÅ 
Services
ÅÅ 
.
ÅÅ !
AddMTRabbitMqBroker
ÅÅ $
(
ÅÅ$ %
configuration
ÅÅ% 2
)
ÅÅ2 3
;
ÅÅ3 4
builderÇÇ 
.
ÇÇ 
Services
ÇÇ 
.
ÇÇ 
AddSwaggerGen
ÇÇ 
(
ÇÇ 
)
ÇÇ  
;
ÇÇ  !
builderÉÉ 
.
ÉÉ 
Services
ÉÉ 
.
ÉÉ 
	AddCarter
ÉÉ 
(
ÉÉ 
)
ÉÉ 
;
ÉÉ 
builderÑÑ 
.
ÑÑ 
Services
ÑÑ 
.
ÑÑ 
AddProblemDetails
ÑÑ "
(
ÑÑ" #
o
ÑÑ# $
=>
ÑÑ% '
o
ÑÑ( )
.
ÑÑ) *%
CustomizeProblemDetails
ÑÑ* A
=
ÑÑB C
ctx
ÑÑD G
=>
ÑÑH J
{ÖÖ 
var
ÜÜ "
problemCorrelationId
ÜÜ 
=
ÜÜ 
Guid
ÜÜ #
.
ÜÜ# $
NewGuid
ÜÜ$ +
(
ÜÜ+ ,
)
ÜÜ, -
.
ÜÜ- .
ToString
ÜÜ. 6
(
ÜÜ6 7
)
ÜÜ7 8
;
ÜÜ8 9
ctx
áá 
.
áá 
ProblemDetails
áá 
.
áá 
Instance
áá 
=
áá  !"
problemCorrelationId
áá" 6
;
áá6 7
}àà 
)
àà 
;
àà 
varää 
app
ää 
=
ää 	
builder
ää
 
.
ää 
Build
ää 
(
ää 
)
ää 
;
ää 
ifåå 
(
åå 
app
åå 
.
åå 
Environment
åå 
.
åå 
IsDevelopment
åå !
(
åå! "
)
åå" #
)
åå# $
{çç 
app
éé 
.
éé 

UseSwagger
éé 
(
éé 
)
éé 
;
éé 
app
èè 
.
èè 
UseSwaggerUI
èè 
(
èè 
)
èè 
;
èè 
}êê 
appíí 
.
íí !
UseHttpsRedirection
íí 
(
íí 
)
íí 
;
íí 
appìì 
.
ìì 
	MapCarter
ìì 
(
ìì 
)
ìì 
;
ìì 
appîî 
.
îî 
MapHealthChecks
îî 
(
îî 
$str
îî 
)
îî 
;
îî 
appññ 
.
ññ 
Run
ññ 
(
ññ 
)
ññ 	
;
ññ	 

staticúú 
Serilog
úú 
.
úú 
ILogger
úú $
CreateSerilogAppLogger
úú -
(
úú- .
)
úúO P
{ùù 
var
ûû 
outputTemplate
ûû 
=
ûû 
$str
ûû t
;
ûût u
return
†† 

new
†† !
LoggerConfiguration
†† "
(
††" #
)
††# $
.
°° 	
MinimumLevel
°°	 
.
°° 
Debug
°° 
(
°° 
)
°° 
.
¢¢ 	
MinimumLevel
¢¢	 
.
¢¢ 
Override
¢¢ 
(
¢¢ 
$str
¢¢ *
,
¢¢* +
LogEventLevel
¢¢, 9
.
¢¢9 :
Information
¢¢: E
)
¢¢E F
.
££ 	
MinimumLevel
££	 
.
££ 
Override
££ 
(
££ 
$str
££ 5
,
££5 6
LogEventLevel
££7 D
.
££D E
Warning
££E L
)
££L M
.
•• 	
MinimumLevel
••	 
.
•• 
Override
•• 
(
•• 
$str
•• '
,
••' (
LogEventLevel
••) 6
.
••6 7
Warning
••7 >
)
••> ?
.
¶¶ 	
MinimumLevel
¶¶	 
.
¶¶ 
Override
¶¶ 
(
¶¶ 
$str
¶¶ ;
,
¶¶; <
LogEventLevel
¶¶= J
.
¶¶J K
Warning
¶¶K R
)
¶¶R S
.
ßß 	
Enrich
ßß	 
.
ßß 
FromLogContext
ßß 
(
ßß 
)
ßß  
.
®® 	
WriteTo
®®	 
.
®® 
Console
®® 
(
®® 
outputTemplate
®® '
:
®®' (
outputTemplate
®®) 7
)
®®7 8
.
©© 	
WriteTo
©©	 
.
©© 
File
©© 
(
©© 
$"
™™ 
$str
™™ 
{
™™ 
DateTime
™™  
.
™™  !
Now
™™! $
:
™™$ %
$str
™™% /
}
™™/ 0
$str
™™0 4
"
™™4 5
,
™™5 6
outputTemplate
´´ 
:
´´ 
outputTemplate
´´ *
,
´´* + 
fileSizeLimitBytes
¨¨ 
:
¨¨ 
default
¨¨  '
,
¨¨' (!
rollOnFileSizeLimit
≠≠ 
:
≠≠  
true
≠≠! %
)
≠≠% &
.
ÆÆ 	
WriteTo
ÆÆ	 
.
ÆÆ 
OpenTelemetry
ÆÆ 
(
ÆÆ 
options
ÆÆ &
=>
ÆÆ' )
{
ØØ 	
options
≤≤ 
.
≤≤ 
Endpoint
≤≤ 
=
≤≤ 
new
≤≤ "
Uri
≤≤# &
(
≤≤& '
$str
≤≤' K
)
≤≤K L
.
≤≤L M
ToString
≤≤M U
(
≤≤U V
)
≤≤V W
;
≤≤W X
options
≥≥ 
.
≥≥ 
Protocol
≥≥ 
=
≥≥ 
OtlpProtocol
≥≥ +
.
≥≥+ ,
HttpProtobuf
≥≥, 8
;
≥≥8 9
options
¥¥ 
.
¥¥ 
IncludedData
¥¥  
=
¥¥! "
IncludedData
¥¥# /
.
¥¥/ 0*
MessageTemplateTextAttribute
¥¥0 L
|
¥¥M N
IncludedData
µµ &
.
µµ& '
TraceIdField
µµ' 3
|
µµ4 5
IncludedData
µµ6 B
.
µµB C
SpanIdField
µµC N
;
µµN O
}
∂∂ 	
)
∂∂	 

.
∑∑ 	#
CreateBootstrapLogger
∑∑	 
(
∑∑ 
)
∑∑  
;
∑∑  !
}∏∏ 
[∫∫ %
ExcludeFromCodeCoverage
∫∫ 
]
∫∫ 
publicªª 
partial
ªª 
class
ªª 
Program
ªª 
{ºº 
	protected
ΩΩ 
Program
ΩΩ 
(
ΩΩ 
)
ΩΩ 
{
ΩΩ 
}
ΩΩ 
}ææ 