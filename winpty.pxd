from libc.stddef cimport wchar_t
from libc.stdlib cimport malloc, free

cdef extern from 'windows.h' nogil:
    ctypedef wchar_t WCHAR
    ctypedef char CHAR
    ctypedef int BOOL
    ctypedef const WCHAR* LPCWSTR
    ctypedef CHAR* LPSTR
    ctypedef const CHAR* LPCSTR
    ctypedef BOOL* LPBOOL
    ctypedef unsigned long DWORD
    ctypedef unsigned int UINT
    ctypedef unsigned long long UINT64
    ctypedef void* PVOID
    ctypedef PVOID HANDLE
    cdef int CP_UTF8
    cdef int WC_ERR_INVALID_CHARS
    cdef int WideCharToMultiByte(UINT, DWORD, LPCWSTR, int, LPSTR, int, LPCSTR, LPBOOL)
    cdef DWORD GetLastError()
    cdef DWORD GetProcessId(HANDLE)

cdef extern from 'winpty.h' nogil:
    cdef int WINPTY_ERROR_SUCCESS
    cdef int WINPTY_ERROR_OUT_OF_MEMORY
    cdef int WINPTY_ERROR_SPAWN_CREATE_PROCESS_FAILED
    cdef int WINPTY_ERROR_LOST_CONNECTION
    cdef int WINPTY_ERROR_AGENT_EXE_MISSING
    cdef int WINPTY_ERROR_UNSPECIFIED
    cdef int WINPTY_ERROR_AGENT_DIED
    cdef int WINPTY_ERROR_AGENT_TIMEOUT
    cdef int WINPTY_ERROR_AGENT_CREATION_FAILED
    ctypedef DWORD winpty_result_t
    cdef struct winpty_error_s:
        pass
    ctypedef winpty_error_s winpty_error_t
    ctypedef winpty_error_t* winpty_error_ptr_t
    cdef winpty_result_t winpty_error_code(winpty_error_ptr_t err)
    cdef LPCWSTR winpty_error_msg(winpty_error_ptr_t err)
    cdef void winpty_error_free(winpty_error_ptr_t err)
    cdef struct winpty_config_s:
        pass
    ctypedef winpty_config_s winpty_config_t
    cdef winpty_config_t* winpty_config_new(UINT64 agentFlags, winpty_error_ptr_t* err)
    cdef void winpty_config_free(winpty_config_t* cfg)
    cdef void winpty_config_set_initial_size(winpty_config_t* cfg, int cols, int rows)
    cdef void winpty_config_set_mouse_mode(winpty_config_t* cfg, int mouseMode)
    cdef void winpty_config_set_agent_timeout(winpty_config_t* cfg, DWORD timeoutMs)
    cdef struct winpty_s:
        pass
    ctypedef winpty_s winpty_t
    cdef winpty_t* winpty_open(const winpty_config_t* cfg, winpty_error_ptr_t* err)
    cdef HANDLE winpty_agent_process(winpty_t* wp)
    cdef LPCWSTR winpty_conin_name(winpty_t* wp)
    cdef LPCWSTR winpty_conout_name(winpty_t* wp)
    cdef LPCWSTR winpty_conerr_name(winpty_t* wp)
    cdef BOOL winpty_set_size(winpty_t* wp, int cols, int rows, winpty_error_ptr_t* err)
    cdef void winpty_free(winpty_t* wp)
