#!/usr/bin/env bash

# This is the driver for a shell function which is copied below.
#
#   #We need this so we can alter the state of the parent shell, this acts as a
#   #wrapper around the underlying script.
#   function dirstack() {
#     jump)
#       if dirstack_driver peek ; then
#         cd $(dirstack_driver peek)
#       fi
#     ;;
#     pop)
#       dirstack empty? && dirstack fail 1 ">>Empty Stack<<"
#       dirstack jump && dirstack burn
#     ;;
#     *) dirstack_driver $@ ;;
#     esac
#   }
#
# this needs to live in $SCRIPT_HOME/etc/function.d/spec.d/dirstack
#
# As noted above, this is needed so we can modify the parent shell's path. Only
# `jump` and `pop` need to be implemented at this level. Everything else can
# stay off-the-grid and live in this script.

# `true ${VAR:=somevariable}` sets a variable to a default, even if it's as
# yet unset. Equivalent to ruby's `foo ||= 123`
true ${DIRSTACK_STACKFILE:="/home/jfredett/gandalf/dirstack/stack"}

# ensures it exists if it was removed for whatever reason
touch $DIRSTACK_STACKFILE

source /home/jfredett/gandalf/dirstack/lib/dirstack_include

# FIXME: I'm likely going to have a lot of shell to sling around, this is
# not the best way to store it. At time of writing I'm hacking apart gandalf 
# try to get this working, but I suspect I may need to rewrite it.

# determines whether the given argument is a name that exists on the PATH,
# or a file that exists at the fully specified location, or is a function or
# alias.
exists() {
  which "$1" || [ -e "$1" ] || type -p "$1"
} &>/dev/null

dirstack::push() {
  local dir="${1:-`pwd`}"
  echo " << $dir"
  echo "$dir" >> $DIRSTACK_STACKFILE
}

dirstack::fail() {
  local code=$1 ; shift
  echo "$@"
  exit $code
}

dirstack::burn() {
  dirstack empty? && dirstack fail 2 "Stack too small"
  sed -i -e '$d' $DIRSTACK_STACKFILE
}

dirstack::size() {
  [ -f "$DIRSTACK_STACKFILE" ] || echo 0
  local out="$(wc -l $DIRSTACK_STACKFILE)"
  echo ${out%%$DIRSTACK_STACKFILE}
}

dirstack::swap() {
  [ $(dirstack size) -lt 2 ] && dirstack fail 2 "Stack too small"

  local top="$(dirstack peek)" ; dirstack burn
  local sub="$(dirstack peek)" ; dirstack burn
  dirstack push $top ; dirstack push $sub
}

dirstack::clear() {
  rm $DIRSTACK_STACKFILE
  touch $DIRSTACK_STACKFILE
}

dirstack::dup() {
  dirstack push $(dirstack peek)
}

dirstack::empty?() { [ $(dirstack size) = 0 ] ; }
dirstack::nonempty?() { ! dirstack empty? ; }

dirstack::peek() {
  dirstack empty? && dirstack fail 1 ">>Empty Stack<<"
  tail -n1 "$DIRSTACK_STACKFILE"
  return 0
}

dirstack::show() {
  if exists tac ; then
    echo "-------- DIRECTORY STACK --------"
    tac $DIRSTACK_STACKFILE
    echo "---------------------------------"
  else
    dirstack fail 4 "Must install tac for show functionality"
  fi
}

dirstack::help() {
  cat << HELP
  usage: dirstack <command> [options]

  the commands divided into two categories:

  Barewords:
    These are top-level functions included automatically in the environment

    burn | remove the top element of the stack
    jump | jump to a directory without popping it off the stack
    push | push the current directory onto the stack,
    pop  | pop a directory off the stack (if the stack is non-empty), cd to that directory
    swap | swap the top two elements on the stack

  Prefixed:
    These must be prefixed with a call to 'dirstack' proper

    clear  | blow away the whole stack
    dup    | duplicates the top element of the stack
    empty? | sets \$? to 1 if the stack is empty, 0 otherwise
    peek   | view the top directory on the stack
    show   | view the whole stack
HELP
}

cmd=${1:-help} ; shift
dirstack::$cmd $@
