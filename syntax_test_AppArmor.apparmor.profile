# SYNTAX TEST "AppArmor.sublime-syntax"

# AppArmor profile
# <- source.apparmor comment.line.apparmor punctuation.definition.comment.apparmor

abi <abi/3.0>,
# <- keyword.control.import.abi.apparmor
# ^^^^^^^^^^^ meta.preprocessor.abi.apparmor
#   ^ punctuation.definition.string.begin.apparmor
#    ^^^^^^^ string.quoted.other.lt-gt.apparmor
#           ^ punctuation.definition.string.end.apparmor
#            ^ punctuation.separator.comma.apparmor

abi "/etc/apparmor.d/abi/kernel-5.4-vanilla",
#   ^ punctuation.definition.string.begin.apparmor
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.apparmor meta.string.apparmor
#                                          ^ punctuation.definition.string.end.apparmor
#                                           ^ punctuation.separator.comma.apparmor

include <tunables/global>
# <- keyword.control.import.include.apparmor
# ^^^^^^^^^^^^^^^^^^^^^^^ meta.preprocessor.include.apparmor
#       ^^^^^^^^^^^^^^^^^ string.quoted.other.lt-gt.apparmor
include <tunables/home>

#include if exists "incredible s\tring"
# <- invalid.deprecated.pound-include.apparmor
#                  ^ punctuation.definition.string.begin.apparmor
#                  ^^^^^^^^^^^^^^^^^^^^ string.quoted.double.apparmor meta.string.apparmor
#                               ^^ constant.character.escape.apparmor
#                                     ^ punctuation.definition.string.end.apparmor

@{exec_path} = /such/a/path /another[0-9]_*/{,one}
# <- punctuation.definition.variable.apparmor
 # <- punctuation.section.interpolation.begin.apparmor
# ^ variable.other.readwrite.apparmor
#          ^ punctuation.section.interpolation.end.apparmor
#            ^ keyword.operator.assignment.apparmor
#              ^^^^^^^^^^^^ string.regexp.apparmor
#                          ^ - string.regexp.apparmor
#                           ^^^^^^^^^^^^^^^^^^^^^^ string.regexp.apparmor
#                                   ^ meta.set.regexp.apparmor punctuation.definition.set.begin.regexp.apparmor
#                                    ^ constant.other.range.regexp.apparmor
#                                     ^ punctuation.separator.sequence.regexp.apparmor
#                                      ^ constant.other.range.regexp.apparmor
#                                       ^ punctuation.definition.set.end.regexp.apparmor
#                                         ^ keyword.operator.quantifier.regexp.apparmor
#                                           ^ keyword.operator.quantifier.regexp.apparmor
#                                            ^ keyword.operator.quantifier.regexp.apparmor
#                                                ^ keyword.operator.quantifier.regexp.apparmor

@{root} = /nonexistent

@{uuid} = f3f3a904-bdcc-481b-be30-ccc751c4922c
#         ^ string.regexp.apparmor

@{exec_path} += @{uuid}
#            ^^ keyword.operator.assignment.apparmor
#               ^ punctuation.definition.variable.apparmor
#                ^ punctuation.section.interpolation.begin.apparmor
#                 ^ variable.other.readwrite.apparmor

alias /home/ -> /mnt/users/,
# <- storage.type.alias.apparmor
#     ^ string.unquoted.absolute-path.apparmor
#            ^^ keyword.operator.arrow.apparmor
#               ^ string.unquoted.absolute-path.apparmor
#                          ^ punctuation.separator.comma.apparmor

profile profile_N4m3 @{exec_path} flags=(attach_disconnected) {
# <- storage.type.profile.apparmor keyword.declaration.profile.apparmor
#       ^^^^^^^^^^^^ entity.name.profile.apparmor
#                    ^ punctuation.definition.variable.apparmor
#                                 ^ entity.name.tag.profile-flags.apparmor
#                                      ^ keyword.operator.assignment.apparmor
#                                       ^ meta.parens.profile-flags.apparmor punctuation.section.parens.begin
#                                        ^ constant.language.profile-flag.apparmor
#                                                           ^ punctuation.section.parens.end
#                                                             ^ punctuation.section.block.begin.profile.apparmor

	# <- meta.block.profile.apparmor

	# Include base abstractions
	# <- comment.line.apparmor
	include <abstractions/base>
	# <- keyword.control.import.include.apparmor

	capability bpf kill,
	# <- entity.other.attribute-name.capability.apparmor
	#          ^ constant.language.capability.apparmor
	#              ^ constant.language.capability.apparmor
	#                  ^ punctuation.separator.comma.apparmor

	change_profile -> **,
	# <- entity.other.attribute-name.change-profile.apparmor
	#              ^^ keyword.operator.arrow.apparmor
	#                 ^^ string.regexp.apparmor
	#                   ^ punctuation.separator.comma.apparmor
	change_profile safe /bin/bash -> libvirt-@{uuid},
	#              ^ constant.language.change-profile-exec-mode.apparmor
	#                   ^ string.regexp.apparmor
	#                             ^^ keyword.operator.arrow.apparmor
	#                                ^ string.regexp.apparmor
	#                                        ^ punctuation.definition.variable.apparmor
	#                                               ^ punctuation.separator.comma.apparmor
	change_profile /bin/bash -> {profile1,profile2},
	#                           ^ string.regexp.apparmor keyword.operator.quantifier.regexp.apparmor
	#                                    ^ keyword.operator.quantifier.regexp.apparmor
	#                                             ^ keyword.operator.quantifier.regexp.apparmor
	#                                              ^ punctuation.separator.comma.apparmor

	deny dbus (send, bind) bus=session,
	# <- constant.language.rule-qualifier.apparmor
	#    ^ entity.other.attribute-name.dbus.apparmor
	#         ^ meta.parens.dbus-accesses.apparmor punctuation.section.parens.begin
	#          ^ constant.language.dbus-access.apparmor
	#              ^ punctuation.separator.comma.apparmor
	#                    ^ punctuation.section.parens.end
	#                      ^ entity.name.tag.dbus-bus.apparmor
	#                         ^ keyword.operator.assignment.apparmor
	#                          ^ constant.language.dbus-bus.apparmor
	#                                 ^ punctuation.separator.comma.apparmor
	dbus receive bus=@{exec_path}/{,foo} path=/com/example/path interface=com.example.Interface,
	#    ^ constant.language.dbus-access.apparmor
	#            ^ entity.name.tag.dbus-bus.apparmor
	#                ^ punctuation.definition.variable.apparmor
	#                             ^ keyword.operator.quantifier.regexp.apparmor
	#                                    ^ entity.name.tag.dbus-cond.apparmor
	#                                        ^ keyword.operator.assignment.apparmor
	#                                         ^ string.regexp.apparmor
	#                                                           ^ entity.name.tag.dbus-cond.apparmor
	#                                                                    ^ keyword.operator.assignment.apparmor
	#                                                                     ^ string.regexp.apparmor
	#                                                                                          ^ punctuation.separator.comma.apparmor
	dbus send
		bus=session
		path=/com/example/path
		interface=com.example.Interface
		member=ExampleMethod
		peer=(name=(com.example.ExampleName1|com.example.ExampleName2)),
		# <- entity.name.tag.dbus-peer-cond.apparmor
		#   ^ keyword.operator.assignment.apparmor
		#    ^ meta.parens.dbus-peer-conds.apparmor punctuation.section.parens.begin
		#     ^ entity.name.tag.dbus-cond.apparmor
		#         ^ keyword.operator.assignment.apparmor
		#          ^ meta.parens.dbus-peer-conds.apparmor punctuation.section.parens.begin
		#           ^ string.regexp.apparmor
		#                                                            ^ punctuation.section.parens.end
		#                                                             ^ punctuation.section.parens.end
		#                                                              ^ punctuation.separator.comma.apparmor

	link subset @{HOME}/*.fonts/.uuid.LCK -> @{HOME}/.fonts/.uuid.TMP-*,
	# <- entity.other.attribute-name.link.apparmor
	#    ^ entity.name.tag.link-subset.apparmor
	#           ^ punctuation.definition.variable.apparmor
	#                  ^ string.regexp.apparmor
	#                                     ^^ keyword.operator.arrow.apparmor
	#                                        ^ punctuation.definition.variable.apparmor
	#                                               ^ string.regexp.apparmor
	#                                                                 ^ keyword.operator.quantifier.regexp.apparmor
	#                                                                  ^ punctuation.separator.comma.apparmor - string.regexp.apparmor

	mount options=ro /dev/foo -> /mnt/,
	# <- entity.other.attribute-name.mount.apparmor
	#     ^ entity.name.tag.mount-options.apparmor
	#            ^ keyword.operator.assignment.apparmor
	#             ^ constant.language.mount-flag.apparmor
	#                ^ string.regexp.apparmor
	#                         ^^ keyword.operator.arrow.apparmor
	#                            ^ string.regexp.apparmor
	#                                 ^ punctuation.separator.comma.apparmor
	mount fstype={btrfs,ext*,vfat,ntfs3} /dev/{s,v}d[a-z]*[0-9]* -> @{HOME}/*/,
	#     ^ entity.name.tag.mount-fstype.apparmor
	#           ^ keyword.operator.assignment.apparmor
	#            ^ string.regexp.apparmor keyword.operator.quantifier.regexp.apparmor
	#                                    ^ string.regexp.apparmor
	#                                                    ^ keyword.operator.quantifier.regexp.apparmor
	#                                                            ^^ keyword.operator.arrow.apparmor
	#                                                               ^ punctuation.definition.variable.apparmor
	#                                                                         ^ punctuation.separator.comma.apparmor
	mount options=(rw,atime) fstype=fuse.obexautofs -> @{HOME}/*/*/,
	#             ^ punctuation.section.parens.begin
	#              ^ constant.language.mount-flag.apparmor
	#                               ^ string.regexp.apparmor
	#                                               ^^ keyword.operator.arrow.apparmor
	#                                                              ^ punctuation.separator.comma.apparmor
	umount,
	# <- entity.other.attribute-name.mount.apparmor

	network,
	# <- entity.other.attribute-name.network.apparmor
	network inet dgram,
	# <- entity.other.attribute-name.network.apparmor
	#       ^ constant.language.network-domain.apparmor
	#            ^ constant.language.network-type.apparmor
	#                 ^ punctuation.separator.comma.apparmor
	network inet6 udp,
	#             ^ constant.language.network-protocol.apparmor
	#                ^ punctuation.separator.comma.apparmor
	network netlink,
	#       ^ constant.language.network-domain.apparmor
	#              ^ punctuation.separator.comma.apparmor

	pivot_root,
	# <- entity.other.attribute-name.pivot-root.apparmor
	#         ^ punctuation.separator.comma.apparmor
	pivot_root oldroot=/mnt/root/old/ /mnt/root/,
	#          ^ entity.name.tag.pivot-root-oldroot.apparmor
	#                 ^ keyword.operator.assignment.apparmor
	#                  ^ string.regexp.apparmor
	#                                 ^ string.regexp.apparmor
	#                                           ^ punctuation.separator.comma.apparmor
	pivot_root oldroot=/mnt/root/old/ /mnt/root/ -> pivot_@{profile},
	#                                            ^^ keyword.operator.arrow.apparmor
	#                                               ^ string.regexp.apparmor
	#                                                     ^ punctuation.definition.variable.apparmor
	#                                                               ^ punctuation.separator.comma.apparmor

	ptrace peer=@{profile_name}/bin/foo,
	# <- entity.other.attribute-name.ptrace.apparmor
	#      ^ entity.name.tag.ptrace-peer.apparmor
	#          ^ keyword.operator.assignment.apparmor
	#           ^ punctuation.definition.variable.apparmor
	#                          ^ string.regexp.apparmor
	#                                  ^ punctuation.separator.comma.apparmor
	ptrace (readby, tracedby) peer={kmod,unconfined},
	#      ^ meta.parens.ptrace-accesses.apparmor punctuation.section.parens.begin
	#       ^ constant.language.ptrace-access.apparmor
	#             ^ punctuation.separator.comma.apparmor
	#                              ^ string.regexp.apparmor keyword.operator.quantifier.regexp.apparmor
	#                                               ^ punctuation.separator.comma.apparmor

	set rlimit nice <= -20,
	# <- entity.other.attribute-name.rlimit.apparmor
	#   ^ entity.other.attribute-name.rlimit.apparmor
	#          ^ constant.language.rlimit.apparmor
	#               ^^ keyword.operator.arithmetic.apparmor
	#                  ^ keyword.operator.arithmetic.apparmor
	#                   ^^ constant.numeric.integer.decimal.apparmor
	#                     ^ punctuation.separator.comma.apparmor
	set rlimit nice <= infinity,
	#                  ^ constant.language.infinity.apparmor
	#                          ^ punctuation.separator.comma.apparmor
	set rlimit data <= 100M,
	#                  ^^^ constant.numeric.integer.decimal.apparmor
	#                     ^ constant.numeric.suffix.apparmor
	#                      ^ punctuation.separator.comma.apparmor
	set rlimit rttime <= 10ms,
	#                    ^^ constant.numeric.integer.decimal.apparmor
	#                      ^^ constant.numeric.suffix.apparmor
	#                        ^ punctuation.separator.comma.apparmor

	signal (receive) set=(term hup kill rtmin+1) peer=gdm*,
	# <- entity.other.attribute-name.signal.apparmor
	#      ^ meta.parens.signal-accesses.apparmor punctuation.section.parens.begin
	#       ^ constant.language.signal-access.apparmor
	#              ^ punctuation.section.parens.end
	#                ^ entity.name.tag.signal-set.apparmor
	#                   ^ keyword.operator.assignment.apparmor
	#                    ^ meta.parens.signal-list.apparmor punctuation.section.parens.begin
	#                     ^ constant.language.signal.apparmor
	#                          ^ constant.language.signal.apparmor
	#                                    ^ constant.language.signal.apparmor
	#                                          ^ punctuation.section.parens.end
	#                                            ^ entity.name.tag.signal-peer.apparmor
	#                                                ^ keyword.operator.assignment.apparmor
	#                                                 ^ string.regexp.apparmor
	#                                                    ^ keyword.operator.quantifier.regexp.apparmor
	#                                                     ^ punctuation.separator.comma.apparmor - string.regexp.apparmor

	deny unix,
	# <- constant.language.rule-qualifier.apparmor
	#    ^ entity.other.attribute-name.unix.apparmor
	#        ^ punctuation.separator.comma.apparmor
	unix (receive, send) peer=(label=@{profile_name}),
	#    ^ meta.parens.unix-accesses.apparmor punctuation.section.parens.begin
	#     ^ constant.language.unix-access.apparmor
	#            ^ punctuation.separator.comma.apparmor
	#                  ^ punctuation.section.parens.end
	#                    ^ entity.name.tag.unix-peer-cond.apparmor
	#                        ^ keyword.operator.assignment.apparmor
	#                         ^ meta.parens.unix-peer-conds.apparmor punctuation.section.parens.begin
	#                          ^ entity.name.tag.unix-peer-cond.apparmor
	#                               ^ keyword.operator.assignment.apparmor
	#                                ^ punctuation.definition.variable.apparmor
	#                                               ^ punctuation.section.parens.end
	#                                                ^ punctuation.separator.comma.apparmor
	unix (getattr, shutdown) addr=none,
	#                        ^ entity.name.tag.unix-cond.apparmor
	#                            ^ keyword.operator.assignment.apparmor
	#                             ^ string.regexp.apparmor
	#                                 ^ punctuation.separator.comma.apparmor
	unix (connect, receive, send) type=stream peer=(label=/foo,addr="@bar"),
	#                             ^ entity.name.tag.unix-cond.apparmor
	#                                 ^ keyword.operator.assignment.apparmor
	#                                         ^ entity.name.tag.unix-peer-cond.apparmor
	#                                             ^ keyword.operator.assignment.apparmor
	#                                               ^ entity.name.tag.unix-peer-cond.apparmor
	#                                                     ^ string.regexp.apparmor
	#                                                         ^ punctuation.separator.comma.apparmor
	#                                                          ^ entity.name.tag.unix-peer-cond.apparmor
	#                                                              ^ keyword.operator.assignment.apparmor
	#                                                               ^ string.quoted.double.apparmor punctuation.definition.string.begin.apparmor 
	#                                                                      ^ punctuation.separator.comma.apparmor

	include if exists <local/usr.bin.program>
	# <- keyword.control.import.include.apparmor
	#       ^ keyword.control.conditional.apparmor
	#          ^ keyword.operator.word.exists.apparmor
}
# <- punctuation.section.block.end.profile.apparmor

profile firefox @{exec_path} xattrs=(
# <- storage.type.profile.apparmor keyword.declaration.profile.apparmor
#       ^ entity.name.profile.apparmor
#                            ^ entity.name.tag.profile-xattrs.apparmor
#                                  ^ keyword.operator.assignment.apparmor
#                                   ^ meta.parens.profile-xattrs.apparmor punctuation.section.parens.begin
	security.apparmor="trusted"
	# <- string.unquoted.xattrs.apparmor
	#       ^ punctuation.accessor.dot.apparmor
	#        ^ string.unquoted.xattrs.apparmor
	#                ^ keyword.operator.assignment.apparmor
	#                 ^^^^^^^^ string.quoted.double.apparmor
	user.trust=tier/*
	# <- string.unquoted.xattrs.apparmor
	#          ^ string.regexp.apparmor
	#               ^ keyword.operator.quantifier.regexp.apparmor
) {
# <- punctuation.section.parens.end
# ^ punctuation.section.block.begin.profile.apparmor

	r /bin/foo,
	# <- constant.language.file-access-modes.apparmor
	# ^ string.regexp.apparmor
	#         ^ punctuation.separator.comma.apparmor
	file /** rw,
	# <- entity.other.attribute-name.file.apparmor
	#    ^ string.regexp.apparmor
	#     ^^ keyword.operator.quantifier.regexp.apparmor
	#        ^ constant.language.file-access-modes.apparmor
	#          ^ punctuation.separator.comma.apparmor
	owner @{root}/bin/** px -> profile,
	# <- constant.language.rule-qualifier.apparmor
	#     ^ punctuation.definition.variable.apparmor
	#            ^ string.regexp.apparmor
	#                       ^^ keyword.operator.arrow.apparmor
	#                          ^ entity.name.profile.apparmor
	#                                 ^ punctuation.separator.comma.apparmor
	owner file /bin/** px -> profile,
	#     ^ entity.other.attribute-name.file.apparmor
	#          ^ string.regexp.apparmor
	#                  ^ constant.language.file-access-modes.apparmor
	#                        ^ entity.name.profile.apparmor
	#                               ^ punctuation.separator.comma.apparmor
}

/usr/bin/foo {
# <- string.regexp.apparmor
#            ^ punctuation.section.block.begin.profile.apparmor

	# <- meta.block.profile.apparmor

	profile baz /foo/bar/* flags=(audit) {
	# <- storage.type.profile.apparmor keyword.declaration.profile.apparmor
	#       ^ entity.name.profile.apparmor
	#           ^ string.regexp.apparmor
	#                      ^ entity.name.tag.profile-flags.apparmor
	#                                    ^ punctuation.section.block.begin.profile.apparmor

		# <- meta.block.profile.apparmor meta.block.profile.apparmor

		owner /proc/[0-9]*/stat r,
		# <- constant.language.rule-qualifier.apparmor
		#     ^ string.regexp.apparmor
		#                       ^ constant.language.file-access-modes.apparmor
		#                        ^ punctuation.separator.comma.apparmor
	}
	# <- punctuation.section.block.end.profile.apparmor

	profile /bin/sh {}
	# <- storage.type.profile.apparmor keyword.declaration.profile.apparmor
	#       ^^^^^^^ string.regexp.apparmor
	#               ^ punctuation.section.block.begin.profile.apparmor
	#                ^ punctuation.section.block.end.profile.apparmor

	^foo flags=(complain) {
	# <- punctuation.definition.keyword.caret.apparmor
	# ^ entity.name.profile.hat.apparmor
	#    ^ entity.name.tag.profile-flags.apparmor
	#         ^ keyword.operator.assignment.apparmor
	#          ^ meta.parens.profile-flags.apparmor punctuation.section.parens.begin
	#           ^ constant.language.profile-flag.apparmor
	#                   ^ punctuation.section.parens.end
	#                     ^ punctuation.section.block.begin.profile.apparmor

		# <- meta.block.profile.apparmor meta.block.profile.apparmor

		/var/spool/* rwl,
		# <- string.regexp.apparmor
		#            ^ constant.language.file-access-modes.apparmor
		#               ^ punctuation.separator.comma.apparmor
	}
	# <- punctuation.section.block.end.profile.apparmor

	hat foo2 {}
	# <- storage.type.hat.apparmor keyword.declaration.hat.apparmor
	#   ^ entity.name.profile.apparmor
	#        ^ punctuation.section.block.begin.profile.apparmor
	#         ^ punctuation.section.block.end.profile.apparmor
}
