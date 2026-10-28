// Zotero preferences, re-applied on every start. install.sh links this into
// the profile (~/.zotero/zotero/<profile>/user.js).
//
// Metadata syncs through zotero.org; PDFs live in Dropbox as linked files, so
// ZotMoov moves new attachments into the papers folder and Zotero stores the
// links relative to it (the same library then works on every machine).

// Linked files are relative to this folder
user_pref("extensions.zotero.baseAttachmentPath", "/home/ritoban/cloud/dropbox-mit/papers");
user_pref("extensions.zotero.saveRelativeAttachmentPath", true);

// Dropbox syncs the files, not Zotero
user_pref("extensions.zotero.sync.storage.enabled", false);
user_pref("extensions.zotero.sync.storage.groups.enabled", false);

// Rename files from parent metadata, linked files included, using Zotero's
// default template ("Author et al. - 2014 - Title.pdf"). The template is a
// synced library setting (Settings > General > Customize Filename Format),
// not a pref.
user_pref("extensions.zotero.autoRenameFiles", true);
user_pref("extensions.zotero.autoRenameFiles.linked", true);

// ZotMoov: move new attachments into the (flat) papers folder as linked files
user_pref("extensions.zotmoov.dst_dir", "/home/ritoban/cloud/dropbox-mit/papers");
user_pref("extensions.zotmoov.enable_automove", true);
user_pref("extensions.zotmoov.file_behavior", "move");
user_pref("extensions.zotmoov.enable_subdir_move", false);
user_pref("extensions.zotmoov.process_synced_files", false);
user_pref("extensions.zotmoov.delete_files", false);
user_pref("extensions.zotmoov.add_zotmoov_tag", false);
