/* void helpfunc() {
    while (1) {
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
    }
}
*/

mp_obj_t mp_vfs_umount(mp_obj_t mnt_in) {
        mp_vfs_mount_t *vfs = NULL;
    size_t mnt_len;
    const char *mnt_str = NULL;
    if (mp_obj_is_str(mnt_in)) {
        mnt_str = mp_obj_str_get_data(mnt_in, &mnt_len);
    }
    for (mp_vfs_mount_t **vfsp = &MP_STATE_VM(vfs_mount_table); *vfsp != NULL; vfsp = &(*vfsp)->next) {
        if ((mnt_str != NULL && !memcmp(mnt_str, (*vfsp)->str, mnt_len + 1)) || (*vfsp)->obj == mnt_in) {
            vfs = *vfsp;
            *vfsp = (*vfsp)->next;
            break;
        }
    }

    if (vfs == NULL) {
        mp_raise_OSError(MP_EINVAL);
    }

        if (MP_STATE_VM(vfs_cur) == vfs) {
        MP_STATE_VM(vfs_cur) = MP_VFS_ROOT;
    }

        mp_vfs_proxy_call(vfs, MP_QSTR_umount, 0, NULL);

    return mp_const_none;
}