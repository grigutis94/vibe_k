export function getAuthorAvatarUrl(name) {
  const baseUrl = 'https://api.dicebear.com/9.x/avataaars/svg'
  const normalized = (name || '').trim()
  const seed = encodeURIComponent(normalized || 'anonymous')

  return `${baseUrl}?seed=${seed}`
}

