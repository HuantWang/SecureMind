static int
ble_hs_hci_evt_le_adv_rpt_first_pass(const void *data, unsigned int len)
{
    const struct ble_hci_ev_le_subev_adv_rpt *ev = data;
    const struct adv_report *rpt;
    int i;

    if (len < sizeof(*ev))
    {
        return BLE_HS_ECONTROLLER;
    }

    len -= sizeof(*ev);
    data += sizeof(*ev);

    if (ev->num_reports < BLE_HCI_LE_ADV_RPT_NUM_RPTS_MIN ||
        ev->num_reports > BLE_HCI_LE_ADV_RPT_NUM_RPTS_MAX)
    {
        return BLE_HS_EBADDATA;
    }

    for (i = 0; i < ev->num_reports; i++)
    {
        if (len < sizeof(*rpt) + 1)
        {
            return BLE_HS_ECONTROLLER;
        }

        rpt = data;

        len -= sizeof(*rpt) + 1;
        data += sizeof(rpt) + 1;

        if (rpt->data_len > len)
        {
            return BLE_HS_ECONTROLLER;
        }

        len -= rpt->data_len;
        data += rpt->data_len;
    }

    if (len)
    {
        return BLE_HS_ECONTROLLER;
    }

    return 0;
}