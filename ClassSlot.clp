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
; ClassSlot.clp - A container class to build slots for a given class
; 
; Written By Joshua Scoggins (10/15/2012)
;-----------------------------------------------------------------------------
(defclass ClassSlot (is-a USER)
  (slot slot-name (type SYMBOL))
  (slot is-multislot (type SYMBOL) (allowed-values FALSE TRUE))
  ;we store the default facet as an object because it makes it more flexible for
  ;handling logic
  ;we have the programmer define default how they want it
  (slot default-facet (type STRING) (default-dynamic ""))
  ;constraints are defined in the same way as well
  (slot constraints (type STRING) (default-dynamic ""))
  (slot access (type SYMBOL) (allowed-symbols read-write read-only initialize-only))
  (slot storage (type SYMBOL) (allowed-symbols local shared))
  (slot propagation (type SYMBOL) (allowed-symbols inherit no-inherit))
  (slot source (type SYMBOL) (allowed-symbols exclusive composite))
  (slot pattern-match (type SYMBOL) (allowed-symbols reactive non-reactive))
  (slot visibility (type SYMBOL) (allowed-symbols private public))
  (slot create-accessor (type STRING) (default-dynamic ""))
  (slot override-message (type STRING) (default-dynamic ""))
  (slot other (type STRING) (default-dynamic ""))
  (message-handler build))

(defmessage-handler ClassSlot build ()
                    (return 
                     (format nil "(%s %s %s %s (access %s) (storage %s) (propagation %s) (source %s) (pattern-match %s) (visibility %s) %s %s %s)" 
                                    (if ?self:is-multislot then "multislot"
                                     else "slot")
                                    ?self:slot-name 
                                    ?self:constraints
                                    ?self:default-facet
                                    ?self:access 
                                    ?self:storage
                                    ?self:propagation 
                                    ?self:source 
                                    ?self:pattern-match
                                    ?self:visibility 
                                    ?self:create-accessor
                                    ?self:override-message
                                    ?self:other)))


