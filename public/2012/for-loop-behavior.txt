title: For loop behavior in PHP
created: 2012-07-09T13:00:00+0200
teaser: rollercoaster.jpg
tags: [ english, note, dev, php ]
template: post.en.tpl


I always asked myself how often a function gets evaluated if you place it in the
break condition of a for loop (or a for-each loop). Unfortunately I have always
been too lazy to look for an answer &ndash; until today.

Let’s have a look at an implementation in _PHP_:

~~~ php
<?php

function times() {
  echo "evaluation\n"; // report evaluation
  return 5;
}

echo "# for loop:\n\n";

for ($i = 0; $i < times(); $i++) {
  echo $i . "\n";
}

function set() {
  echo "evaluation\n"; // report evaluation
  return array(0, 1, 2, 3, 4);
}

echo "\n# for-each loop:\n\n";

foreach (set() as $i) {
  echo $i . "\n";
}
~~~

This will print

~~~
# for loop:

evaluation
0
evaluation
1
evaluation
2
evaluation
3
evaluation
4
evaluation

# for-each loop:

evaluation
0
1
2
3
4
~~~

As we can see, PHP evaluates the break condition of a _for loop_ at each
iteration, whereas in a _foreach loop_, the set of values over which the loop
iterates, only gets evaluated once.

So, if you use a function with an expensive calculation as a break condition in
a for loop, just store that value in a temporary variable. E.g.:

~~~ php
<?php

for ($i = 0, $times = times(); $i < $times; $i++) {
  // ...
}
~~~
