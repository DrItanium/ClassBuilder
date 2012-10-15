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
 (slot name (type SYMBOL))
 (slot is-multislot (type SYMBOL) (allowed-values FALSE TRUE))
 (slot default-value)
 (slot default-dynamic-value)
 (multislot type (type SYMBOL) (allowed-values ANY SYMBOL STRING LEXEME INTEGER
                           FLOAT NUMBER INSTANCE-NAME INSTANCE-ADDRESS INSTANCE
                           EXTERNAL-ADDRESS FACT-ADDRESS))
 (multislot allowed-symbols (type SYMBOL))
 (multislot allowed-strings (type STRING))
 (multislot allowed-lexemes (type LEXEME))
 (multislot allowed-floats (type FLOAT))
 (multislot allowed-numbers (type NUMBER))
 (multislot allowed-instance-names (type INSTANCE-NAME))
 (multislot allowed-classes (type SYMBOL))
 (slot access (type SYMBOL) (allowed-symbols read-write read-only
                             initialize-only))
 (slot storage (type SYMBOL) (allowed-symbols local shared))
 (slot propagation (type SYMBOL) (allowed-symbols inherit no-inherit))
 (slot source (type SYMBOL) (allowed-symbols exclusive composite))
 (slot pattern-match (type SYMBOL) (allowed-symbols reactive non-reactive))
 (slot visibility (type SYMBOL) (allowed-symbols private public))
 (slot create-accessor (type SYMBOL) (allowed-symbols NONE read write
                                      read-write) (default-dynamic
                                        read-write))
 (slot override-message (type SYMBOL) (default-dynamic DEFAULT))
 (message-handler build))

 
