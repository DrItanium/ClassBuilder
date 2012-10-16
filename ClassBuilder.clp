;Copyright (c) 2012, Joshua Scoggins 
;All rights reserved.
;
;Redistribution and use in source and binary forms, with or without
;modification, are permitted provided that the following conditions are met:
;    * Redistributions of source code must retain the above copyright
;      notice, this list of conditions and the following disclaimer.
;    * Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in the
;      documentation and/or other materials provided with the distribution.
;    * Neither the name of Joshua Scoggins nor the
;      names of its contributors may be used to endorse or promote products
;      derived from this software without specific prior written permission.
;
;THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
;ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;DISCLAIMED. IN NO EVENT SHALL Joshua Scoggins BE LIABLE FOR ANY
;DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
;LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
;ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;-----------------------------------------------------------------------------
; ClassBuilder.clp - A container class to make the process of defining a new
; class dynamically as easy as possible 
; 
; Written By Joshua Scoggins (10/15/2012)
;-----------------------------------------------------------------------------
(defclass ClassBuilder (is-a USER)
 (slot class-name (type SYMBOL) (default-dynamic nil))
 (slot comment (type STRING) (default-dynamic ""))
 (multislot isa (type SYMBOL INSTANCE) (allowed-classes ClassBuilder))
 (multislot slots (type INSTANCE) (allowed-classes ClassSlot))
 (multislot handler-documentation (type INSTANCE-NAME INSTANCE-ADDRESS)
  (allowed-classes ClassMessageHandlerDocumentation))
 (slot role (type SYMBOL) (allowed-symbols concrete abstract))
 (slot pattern-match (type SYMBOL) (allowed-symbols reactive non-reactive))
 (message-handler build))

(defmessage-handler ClassBuilder build ()
  ; build the class
  ; start with the is-a elements
  (bind ?isa "(is-a ")
  (bind ?slots "") 
  (bind ?mhdoc "")
  (if (= 0 (length$ ?self:isa)) then
   (bind ?isa "(is-a USER)")
   else
  (progn$ (?class ?self:isa)
   (if (not (send ?class get-has-been-built)) then (send ?class build))
   (bind ?isa (format nil "%s %s" ?isa (send ?class get-class-name))))
  (bind ?isa (format nil "%s)" ?isa)))
  (progn$ (?slot ?self:slots)
   (bind ?slots (format nil "%s %s" ?slots (send ?slot build))))
  (progn$ (?mh ?self:handler-documentation)
   (bind ?mhdoc (format nil "%s %s" ?mhdoc (send ?mh build))))
  (bind ?buildString 
   (format nil 
    "(defclass %s %s %s (role %s) (pattern-match %s) %s %s)" 
    ?self:class-name ?self:comment ?isa ?self:role ?self:pattern-match ?slots
    ?mhdoc))
  (build ?buildString)
  (return ?buildString))

