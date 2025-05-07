
        #define MAP_FUNCTION(func_name, buffer)  func_name(buffer)
        #define VULNERABLE_FUNCTION(buffer)  gets(buffer)
        
guint tvb_length(tvbuff_t *tvb)
{
    DISSECTOR_ASSERT(tvb && tvb->initialized);

    return tvb->length;
}
